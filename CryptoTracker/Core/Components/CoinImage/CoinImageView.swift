//
//  CoinImageView.swift
//  CryptoTracker
//
//  Created by Halisson da Silva Jesus on 05/06/24.
//

import SwiftUI
import Kingfisher

struct CoinImageView: View {
    
    let imageUrl: String
    
    var body: some View {
        KFImage(URL(string: imageUrl))
            .placeholder {
                ProgressView()
            }
            .resizable()
            .scaledToFit()
            .frame(width: 30, height: 30)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinImageView(imageUrl: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501401")
}
