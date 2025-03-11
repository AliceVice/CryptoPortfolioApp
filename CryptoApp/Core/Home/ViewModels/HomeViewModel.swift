//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 07/03/2025.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    
    /// A shared instance for SwiftUI previews.
    static let preview: HomeViewModel = {
        let viewModel = HomeViewModel()
        return viewModel
    }()
        
    enum SortOption {
        case rank, rankReversed
        case holdings, holdingsReversed
        case price, priceReversed
    }
    
    @Published var statistics: [Statistic] = []
    @Published var shownCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var sortOption: SortOption = .holdings
    
    private let coinDataService: CoinDataService = .init()
    private let marketDataService: MarketDataService = .init()
    
//    private let coinDataService: MockCoinDataService = .init()
//    private let marketDataService: MockMarketDataService = .init()
    private let portfolioDataService: PortfolioDataService = .init()
    private var cancellables: Set<AnyCancellable> = []
    
    public init() {
        addSubscribers()
    }
    
    // MARK: - Public section
    
    public func updatePortfolio(coin: Coin, amount: Double) {
        portfolioDataService.updatePortfolio(coin: coin, amount: amount)
    }
    
    public func reloadData() {
        isLoading = true
        coinDataService.getCoins()
        marketDataService.getMarketData()
        HapticManager.notification(type: .success)
    }
    
    // MARK: - Private section
    
    private func addSubscribers() {
        
        // Updates allCoins
        $searchText
            .combineLatest(coinDataService.$allCoins, $sortOption)
            .debounce(for: 0.5, scheduler: DispatchQueue.main)
            .map(filterAndSortCoins)
            .sink { [weak self] filteredCoins in
                self?.shownCoins = filteredCoins
            }
            .store(in: &cancellables)
        
        // get portfolioCoins
        $shownCoins
            .combineLatest(portfolioDataService.$savedEntities)
            .map { (coins, portfolioEntities) -> [Coin] in
                coins.compactMap { coin -> Coin? in
                    guard let entity = portfolioEntities.first(where: { $0.coinID == coin.id }) else {
                        return nil
                    }
                    
                    return coin.setHoldings(to: entity.amount)
                }
            }
            .sink { [weak self] returnedCoins in
                guard let self else { return }
                self.portfolioCoins = self.sortPortfolioCoinsIfNeeded(coins: returnedCoins)
            }
            .store(in: &cancellables)
        
        // get market statistics
        marketDataService.$marketData
            .combineLatest($portfolioCoins)
            .map(mapMarketData)
            .sink { [weak self] returnedStats in
                guard let self else { return }
                self.statistics = returnedStats
                self.isLoading = false
            }
            .store(in: &cancellables)
    }
    
    private func filterAndSortCoins(text: String, coins allCoins: [Coin], sort: SortOption) -> [Coin] {
        let filteredCoins = filterCoins(text: text, coins: allCoins)
        
        // sort coins
        switch sort {
        case .rank, .holdings:
            return filteredCoins.sorted { $0.rank < $1.rank }
        case .rankReversed, .holdingsReversed:
            return filteredCoins.sorted { $0.rank > $1.rank }
        case .price:
            return filteredCoins.sorted { $0.currentPrice > $1.currentPrice }
        case .priceReversed:
            return filteredCoins.sorted { $0.currentPrice < $1.currentPrice }
        }
    }
    
    private func sortPortfolioCoinsIfNeeded(coins: [Coin]) -> [Coin] {
        
        // will only sort by holdings or reversedHoldings if needed
        switch sortOption {
        case .holdings:
            return coins.sorted { $0.currentHoldingsValue > $1.currentHoldingsValue }
        case .holdingsReversed:
            return coins.sorted { $0.currentHoldingsValue < $1.currentHoldingsValue }
        default:
            return coins
        }
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
    
    private func mapMarketData(_ marketData: MarketData?, _ portfolioCoins: [Coin]) -> [Statistic] {
        var stats: [Statistic] = []
        
        guard let data = marketData else { return stats }

        let marketCap = Statistic(
            title: "Market Cap",
            value: data.marketCap,
            percentageChange: data.marketCapChangePercentage24HUsd
        )
        let volume = Statistic(title: "24h Volume", value: data.volume)
        let bitcoinDominance = Statistic(title: "BTC Dominance", value: data.btcDominance)
        
        
        let portfolioValue =
            portfolioCoins
                .map { $0.currentHoldingsValue }
                .reduce(0, +)
        
        let previousValue =
            portfolioCoins.map { coin -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = (coin.priceChangePercentage24h ?? 0) / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        let portfolio = Statistic(
            title: "Portfolio Value",
            value: portfolioValue.asCurrencyWith2Decimals(),
            percentageChange: percentageChange
        )
        
        stats.append(contentsOf: [marketCap, volume, bitcoinDominance, portfolio])
        return stats
    }
    
    private func calculatePortfolioValue() -> (portfolioValue: Double, percentageChange: Double) {
        let portfolioValue =
            portfolioCoins
                .map { $0.currentHoldingsValue }
                .reduce(0, +)
        
        let previousValue =
            portfolioCoins.map { coin -> Double in
                let currentValue = coin.currentHoldingsValue
                let percentChange = coin.priceChangePercentage24h ?? 0 / 100
                let previousValue = currentValue / (1 + percentChange)
                return previousValue
            }
            .reduce(0, +)
        
        let percentageChange = ((portfolioValue - previousValue) / previousValue) * 100
        
        return (portfolioValue, percentageChange)
    }
    
}

