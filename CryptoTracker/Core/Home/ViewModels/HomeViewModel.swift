//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Halisson da Silva Jesus on 04/06/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published private(set) var marketStats: [StatisticModel] = []
    @Published private(set) var allCoins: [CoinModel] = []
    @Published private(set) var portfolioCoins: [CoinModel] = []
    @Published var searchText: String = ""
    
    let service: ApiProtocol
    
    var filteredCoins: [CoinModel] {
        guard !searchText.isEmpty else { return allCoins}
        
        return allCoins.filter { coin in
            coin.name.lowercased().contains(searchText.lowercased()) ||
            coin.symbol.lowercased().contains(searchText.lowercased()) ||
            coin.id.lowercased().contains(searchText.lowercased())
        }
    }
    
    init(service: ApiClient = ApiClient()) {
        self.service = service
    }
    
    func getStatisticsModel(for marketInfo: MarketModel) -> [StatisticModel] {
        return [StatisticModel(title: "MarketCap", value: marketInfo.marketCap, percentageChange: marketInfo.marketCapChangePercentage24HUsd),
                StatisticModel(title: "24H Volume", value: marketInfo.volume),
                StatisticModel(title: "BTC Dominance", value: marketInfo.btcDominance),
                StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange: 0)]
    }
    
    @MainActor
    func getCoins() async {
        let endpoint = CryptoEndpoints.getCoins
        
        Task {
            do {
                let coins = try await service.asyncRequest(endpoint: endpoint, 
                                                           responseModel: [CoinModel].self)
                self.allCoins = coins
            } catch let error as ApiError {
                print(error.message)
            }
        }
    }
    
    @MainActor
    func getMarketInfo() async {
        let endpoint = CryptoEndpoints.market
        
        Task {
            do {
                let info = try await service.asyncRequest(endpoint: endpoint,
                                                          responseModel: MarketResponseModel.self)
                self.marketStats = getStatisticsModel(for: info.data)
            } catch let error as ApiError {
                print(error.message)
            }
        }
    }
}
