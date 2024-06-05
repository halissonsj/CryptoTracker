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
}
