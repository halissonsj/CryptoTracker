//
//  HomeViewModel.swift
//  CryptoTracker
//
//  Created by Halisson da Silva Jesus on 04/06/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published private(set) var allCoins: [CoinModel] = []
    @Published private(set) var portfolioCoins: [CoinModel] = []
    
    let service: ApiProtocol
    
    let coin = CoinModel(id: "bitcoin",
                         symbol: "btc",
                         name: "Bitcoin",
                         image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
                         currentPrice: 70670,
                         marketCapRank: 1,
                         marketCap: 1390232065477,
                         fullyDilutedValuation: 1481395448345,
                         totalVolume: 24747719623,
                         high24H: 70973,
                         low24H: 68544,
                         priceChange24H: 1478.96,
                         priceChangePercentage24H: 2.13749,
                         marketCapChange24H: 24325434656,
                         marketCapChangePercentage24H: 1.7809,
                         circulatingSupply: 19707684,
                         totalSupply: 21000000,
                         maxSupply: 21000000,
                         ath: 73738,
                         athChangePercentage: -4.33331,
                         athDate: "2024-03-14T07:10:36.635Z",
                         atl: 67.81,
                         atlChangePercentage: 103931.38285,
                         atlDate: "2013-07-06T00:00:00.000Z",
                         lastUpdated: "2024-06-04T18:12:19.211Z")
    
    init(service: ApiClient = ApiClient()) {
        self.service = service
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
                // error here
            }
        }
    }
}
