//
//  Mockable.swift
//  CryptoTracker
//
//  Created by Halisson da Silva Jesus on 05/06/24.
//

import Foundation
import Combine

protocol Mockable: AnyObject {
    var bundle: Bundle { get }
    func loadJSON<T: Decodable>(fileName: String, type: T.Type) -> T
}

extension Mockable {
    
    var bundle: Bundle {
        return Bundle(for: type(of: self))
    }
    
    func loadJSON<T: Decodable>(fileName: String, type: T.Type) -> T {
        guard let path = bundle.url(forResource: fileName, withExtension: "json") else {
            fatalError("failed to load JSON")
        }
        
        do {
            let data = try Data(contentsOf: path)
            let decodedObject = try JSONDecoder().decode(type, from: data)
            
            return decodedObject
        } catch {
            fatalError("Failed to decode loaded JSON")
        }
                
    }
}

class MockApiClient: Mockable, ApiProtocol {
    
    func asyncRequest<T>(endpoint: any Endpoint, responseModel: T.Type) async throws -> T where T: Decodable  {
        return loadJSON(fileName: endpoint.mockFile!, type: responseModel.self)
    }
    
    func combineRequest<T>(endpoint: any Endpoint, responseModel: T.Type) -> AnyPublisher<T, ApiError> where T: Decodable {
        return Just(loadJSON(fileName: endpoint.mockFile!, type: responseModel.self) as T)
            .setFailureType(to: ApiError.self)
            .eraseToAnyPublisher()
    }
}
