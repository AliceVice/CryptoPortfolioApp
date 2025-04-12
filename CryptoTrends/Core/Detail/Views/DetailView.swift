//
//  DetailView.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 11/03/2025.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject private var viewModel: DetailViewModel
    @State private var showFullDescription: Bool = false
    
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
            ChartView(coin: viewModel.coin)
                .frame(height: (UIScreen.current?.bounds.height ?? 400) / 3)
            
            VStack(spacing: 20) {
                overViewTitle
                Divider()
                descriptionSection
                overviewGrid
                additionalSection
                linksSection
            }
            .padding()
        }
        .background(
            Color.theme.background.ignoresSafeArea()
        )
        .navigationTitle(viewModel.coin.name)
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                toolbarTrailingItem
            }
        }
    }
    
}

#Preview {
    NavigationStack {
//        DetailView(coin: Coin.previewCoin)
    }
}

extension DetailView {
    
    private var overViewTitle: some View {
        Text("Overview")
            .font(.title)
            .bold()
            .foregroundStyle(Color.theme.accent)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var overviewGrid: some View {
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
    
    private var descriptionSection: some View {
        ZStack {
            if let coinDescription = viewModel.coinDetail?.description?.en,
               !coinDescription.isEmpty
            {
                VStack(alignment: .leading) {
                    Text(coinDescription)
                        .lineLimit(showFullDescription ? nil : 3)
                        .font(.callout)
                        .foregroundStyle(Color.theme.secondaryText)
                    
                    Button {
                        withAnimation(.spring) {
                            showFullDescription.toggle()
                        }
                    } label: {
                        Text(showFullDescription ? "Hide" : "Read more..")
                            .font(.callout)
                            .bold()
                            .tint(Color.theme.accent)
                            .padding(.vertical, 4)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
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
    
    private var toolbarTrailingItem: some View {
        HStack(spacing: 8) {
            Text(viewModel.coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.secondaryText)
            CoinImageView(coin: viewModel.coin)
                .frame(width: 25, height: 25)
        }
    }
    
    private var linksSection: some View {
        VStack(alignment: .leading, spacing: 20) {
            if let websiteURLString = viewModel.coinDetail?.links?.homepage?.first,
               let websiteURL = URL(string: websiteURLString)
            {
                Link("Website", destination: websiteURL)
            }
            
            if let redditURLString = viewModel.coinDetail?.links?.subredditURL,
               let redditURL = URL(string: redditURLString)
            {
                Link("Reddit", destination: redditURL)
            }
        }
        .font(.headline)
        .tint(.blue)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
