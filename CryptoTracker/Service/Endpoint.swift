//
//  EndpointProvider.swift
//  CryptoTracker
//
//  Created by Halisson da Silva Jesus on 05/06/24.
//

import Foundation

enum RequestMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

protocol Endpoint {
    
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var extraHeaders: [String: String] { get }
    var method: RequestMethod { get }
    var queryItems: [URLQueryItem]? { get }
    var body: [String: Any]? { get }
    var mockFile: String? { get }
}

extension Endpoint {
    
    var scheme: String {
        return "https"
    }
    
    var baseURL: String {
        return "baseURL"
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = baseURL
        urlComponents.path = path
        
        if let queryItems = queryItems {
            urlComponents.queryItems = queryItems
        }
        
        guard let url = urlComponents.url else {
            throw ApiError(errorCode: "0", message: "Url error")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("true", forHTTPHeaderField: "X-Use-Cache")
        
        if let body = body {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                throw ApiError(errorCode: "-1", message: "Error encoding http body")
            }
        }
        
        return urlRequest
    }
}
