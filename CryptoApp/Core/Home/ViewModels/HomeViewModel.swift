//
//  HomeViewModel.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 07/03/2025.
//

import Foundation


final class HomeViewModel: ObservableObject {
    
    /// A shared instance for SwiftUI previews.
    static let preview: HomeViewModel = {
        let viewModel = HomeViewModel()
        return viewModel
    }()
    
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    
    init() {
        self.allCoins.append(Coin.previewCoin)
        self.portfolioCoins.append(Coin.previewCoin)
    }
    
}

