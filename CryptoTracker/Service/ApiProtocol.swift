//
//  ApiProtocol.swift
//  CryptoTracker
//
//  Created by Halisson da Silva Jesus on 05/06/24.
//

import Foundation
import Combine

protocol ApiProtocol {
    
    func asyncRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async throws -> T
    func combineRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) -> AnyPublisher<T, ApiError>
}
