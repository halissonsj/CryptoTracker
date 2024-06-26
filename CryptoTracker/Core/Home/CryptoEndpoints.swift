//
//  CryptoEndpoints.swift
//  CryptoTracker
//
//  Created by Halisson da Silva Jesus on 05/06/24.
//

import Foundation

enum CryptoEndpoints: Endpoint {
    
    case getCoins
    case market
    
    var baseURL: String {
        return "api.coingecko.com"
    }
    
    var path: String {
        switch self {
        case .getCoins:
            return "/api/v3/coins/markets"
        case .market:
            return "/api/v3/global"
        }
    }
    
    var extraHeaders: [String: String] {
        return ["x-cg-demo-api-key": "CG-o4z2kdEMiUXTwbThYj8Rkz1f"]
    }
    
    var method: RequestMethod {
        return .get
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getCoins:
            return [URLQueryItem(name: "vs_currency", value: "usd"),
                    URLQueryItem(name: "sparkline", value: "1")]
        case .market:
            return nil
        }
    }
    
    var body: [String : Any]? {
        return nil
    }
    
    var mockFile: String? {
        return nil
    }
}
