//
//  DetailView.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 11/03/2025.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject private var viewModel: DetailViewModel
    private let gridColumns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    private let gridSpacing: CGFloat = 30
    
    init(coin: Coin) {
        self._viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Hi")
                    .frame(height: 150)
                
                overviewSection
                
                additionalSection
            }
            .padding()
        }
        .navigationTitle(viewModel.coin.name)
    }
}

#Preview {
    NavigationStack {
        DetailView(coin: Coin.previewCoin)
    }
}

extension DetailView {
    private var overviewSection: some View {
        VStack(spacing: 20) {
            Text("Overview")
                .font(.title)
                .bold()
                .foregroundStyle(Color.theme.accent)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            LazyVGrid(
                columns: gridColumns,
                alignment: .leading,
                spacing: gridSpacing,
                pinnedViews: []) {
                    ForEach(viewModel.overviewStatistics) { stat in
                        StatisticView(stat: stat)
                    }
                }
        }
    }
    
    private var additionalSection: some View {
        VStack(spacing: 20) {
            Text("Additional Details")
                .font(.title)
                .bold()
                .foregroundStyle(Color.theme.accent)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            LazyVGrid(
                columns: gridColumns,
                alignment: .leading,
                spacing: gridSpacing,
                pinnedViews: []) {
                    ForEach(viewModel.additionalStatistics) { stat in
                        StatisticView(stat: stat)
                    }
                }
        }
    }
}
