//
//  CoinRowView.swift
//  CryptoTracker
//
//  Created by Halisson da Silva Jesus on 04/06/24.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            leftColumn
            
            Spacer()
            
            if showHoldingsColumn {
                centerColumn
            }
            
            rightColumn
        }
        .font(.subheadline)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinRowView(coin: CoinModel(id: "bitcoin",
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
                                lastUpdated: "2024-06-04T18:12:19.211Z"),
                showHoldingsColumn: true)
}

extension CoinRowView {
    
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .frame(minWidth: 30)
            
            Circle()
                .frame(width: 30, height: 30)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color.theme.accent)
        }
    }
    
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundColor(Color.theme.accent)
            
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green : Color.theme.red
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
}
