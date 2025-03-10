//
//  HomeStatsView.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 09/03/2025.
//

import SwiftUI




struct HomeStatsView: View {
        
    @EnvironmentObject private var viewModel: HomeViewModel
    @Binding var showPortfolio: Bool
    
    var body: some View {
        
        HStack(spacing: 4) {
            ForEach(viewModel.statistics) { stat in
                StatisticView(stat: stat)
                    .frame(width: (UIScreen.current?.bounds.width ?? 120) / 3)
            }
        }
        .frame(
            width: UIScreen.current?.bounds.width,
            alignment: showPortfolio ? .trailing : .leading
        )
    }
}

#Preview {
    HomeStatsView(showPortfolio: .constant(false))
        .environmentObject(HomeViewModel.preview)
}
