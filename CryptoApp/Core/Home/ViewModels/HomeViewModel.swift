//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 07/03/2025.
//

import Foundation
import Combine

final class HomeViewModel: ObservableObject {
    
    @Published var statistics: [Statistic] = [
        Statistic(title: "Bitcoin", value: "123456"),
        Statistic(title: "Ethereum", value: "123456", percentageChange: 12.532),
        Statistic(title: "Tether", value: "123456", percentageChange: -92.532),
        Statistic(title: "XRP", value: "123456", percentageChange: 15.232),
    ]
    
    /// A shared instance for SwiftUI previews.
    static let preview: HomeViewModel = {
        let viewModel = HomeViewModel()
        return viewModel
    }()
    
    @Published var shownCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    @Published var searchText: String = ""
    
    private let coinDataService: CoinDataService = .init()
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
    
}

