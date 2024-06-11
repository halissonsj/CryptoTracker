//
//  CoinLogoView.swift
//  CryptoTracker
//
//  Created by Halisson da Silva Jesus on 10/06/24.
//

import SwiftUI

struct CoinLogoView: View {
    
    let coin: CoinModel
    
    var body: some View {
        VStack {
            CoinImageView(imageUrl: coin.image)
                .frame(width: 50, height: 50)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundColor(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Text(coin.name)
                .font(.caption)
                .foregroundColor(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinLogoView(coin: CoinModel(id: "bitcoin",
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
                                 lastUpdated: "2024-06-04T18:12:19.211Z"))
}
