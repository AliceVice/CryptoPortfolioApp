//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 07/03/2025.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    
    @Published var statistics: [Statistic] = []
    
    /// A shared instance for SwiftUI previews.
    static let preview: HomeViewModel = {
        let viewModel = HomeViewModel()
        return viewModel
    }()
    
    @Published var shownCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var searchText: String = ""
    
//    private let coinDataService: CoinDataService = .init()
//    private let marketDataService: MarketDataService = .init()
    
    private let coinDataService: MockCoinDataService = .init()
    private let marketDataService: MockMarketDataService = .init()
    
    private var cancellables: Set<AnyCancellable> = []
    
    public init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        
        // Updates allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map(filterCoins)
            .sink { [weak self] filteredCoins in
                self?.shownCoins = filteredCoins
            }
            .store(in: &cancellables)
        
        // get market statistics
        marketDataService.$marketData
            .map(mapMarketData)
            .sink { [weak self] returnedStats in
                self?.statistics = returnedStats
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(text: String, coins allCoins: [Coin]) -> [Coin] {
        guard !text.isEmpty else {
            return allCoins
        }
        
        let lowercasedText = text.lowercased()
        
        let filteredCoins = allCoins.filter { coin in
            coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
        
        return filteredCoins
    }
    
    private func mapMarketData(_ marketData: MarketData?) -> [Statistic] {
        var stats: [Statistic] = []
        
        guard let data = marketData else { return stats }

        let marketCap = Statistic(title: "Market Cap",
                                  value: data.marketCap,
                                  percentageChange: data.marketCapChangePercentage24HUsd)
        let volume = Statistic(title: "24h Volume", value: data.volume)
        let bitcoinDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
        let portfolioValue = Statistic(title: "Portfolio Value", value: "$0.00", percentageChange: 0)
        
        stats.append(contentsOf: [marketCap, volume, bitcoinDominance, portfolioValue])
        return stats
    }
    
}

