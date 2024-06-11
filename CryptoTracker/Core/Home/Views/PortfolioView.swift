//
//  PortfolioView.swift
//  CryptoTracker
//
//  Created by Halisson da Silva Jesus on 05/06/24.
//

import SwiftUI

struct PortfolioView: View {
    
    @Environment(\.dismiss) var dismiss
    @Binding var searchText: String
    let coins: [CoinModel]
    
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 8) {
                    
                    SearchBarView(searchText: $searchText)
                        .padding(.horizontal)
                    
                    coinLogoList
                    
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton(dismiss: _dismiss)
                }
            }
        }
    }
}

#Preview {
    PortfolioView(searchText: .constant(""),
                  coins: [CoinModel(id: "bitcoin",                                 symbol: "btc",
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
                                    lastUpdated: "2024-06-04T18:12:19.211Z"),
                          CoinModel(id: "aug",                             symbol: "aug",
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
                                            lastUpdated: "2024-06-04T18:12:19.211Z")])
}

extension PortfolioView {
    
    private var coinLogoList: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(coins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                selectedCoin = coin
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1)
                        )
                }
            }
            .frame(height: 120)
            .padding(.leading)
        }
        .scrollIndicators(.hidden)
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        
        return 0
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                
                Spacer()
                
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack {
                Text("Amount holding:")
                
                Spacer()
                
                TextField("Ex: 1.4", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            
            HStack {
                Text("Current value:")
                Spacer()
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .animation(.none)
        .padding()
        .font(.headline)

    }
}
