//
//  HomeStatsView.swift
//  CryptoTracker
//
//  Created by Halisson da Silva Jesus on 05/06/24.
//

import SwiftUI

struct HomeStatsView: View {
    
    var stats: [StatisticModel]
    
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(stats) { stat in
                StatisticView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPortfolio ? .trailing : .leading)
    }
}

#Preview {
    HomeStatsView(stats: [StatisticModel(title: "teste1",
                                         value: "10",
                                         percentageChange: 10.0),
                          StatisticModel(title: "teste2",
                                         value: "20",
                                         percentageChange: 30.0),
                          StatisticModel(title: "teste3",
                                         value: "30"),
                          StatisticModel(title: "teste4",
                                         value: "40",
                                         percentageChange: 30.0)], 
                  showPortfolio: .constant(false))
}
