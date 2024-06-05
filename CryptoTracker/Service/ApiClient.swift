//
//  ApiClient.swift
//  CryptoTracker
//
//  Created by Halisson da Silva Jesus on 05/06/24.
//

import Foundation
import Combine

final class ApiClient: ApiProtocol {
    
    var session: URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 300
        return URLSession(configuration: configuration)
    }
    
    func asyncRequest<T: Decodable>(endpoint: any Endpoint, responseModel: T.Type) async throws -> T{
        do {
            let (data, response) = try await session.data(for: endpoint.asURLRequest())
            return try self.manageResponse(data: data, response: response)
        } catch let error as ApiError {
            throw error
        } catch {
            throw ApiError(errorCode: "0", message: "Unknow Api Error \(error.localizedDescription)")
        }
    }
    
    func combineRequest<T: Decodable>(endpoint: any Endpoint, responseModel: T.Type) -> AnyPublisher<T, ApiError> {
        do {
            return session
                .dataTaskPublisher(for: try endpoint.asURLRequest())
                .tryMap { output in
                    return try self.manageResponse(data: output.data, response: output.response)
                }
                .mapError {
                    $0 as? ApiError ?? ApiError(errorCode: "0", 
                                                message: "Unknow Api Error \($0.localizedDescription)")
                }
                .eraseToAnyPublisher()
        } catch let error as ApiError {
            return AnyPublisher<T, ApiError>(Fail(error: error))
        } catch {
            return AnyPublisher<T, ApiError>(Fail(error: ApiError(errorCode: "0", 
                                                                  message: "Unknow Api Error \(error.localizedDescription)")))
        }
    }
    
    private func manageResponse<T: Decodable>(data: Data, response: URLResponse) throws -> T {
        guard let response = response as? HTTPURLResponse else {
            throw ApiError(errorCode: "0", message: "Invalid HTTP Response")
        }
        
        switch response.statusCode {
        case 200...299:
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                print("!!!!", error)
                throw ApiError(errorCode: "-2", message: "Error decoding data")
            }
        default:
            guard let decodedError = try? JSONDecoder().decode(ApiError.self, from: data) else {
                throw ApiError(statusCode: response.statusCode, 
                               errorCode: "-2",
                               message: "Unknow error")
            }
            
            throw ApiError(statusCode: response.statusCode,
                           errorCode: decodedError.errorCode,
                           message: decodedError.message)
        }
        
    }
}
