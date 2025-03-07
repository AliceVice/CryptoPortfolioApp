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
    
    @Published var allCoins: [Coin] = []
    @Published var portfolioCoins: [Coin] = []
    
    private let coinDataService: CoinDataService = .init()
    private var cancellables: Set<AnyCancellable> = []
    
    public init() {
        addSubscribers()
    }
    
    public func addSubscribers() {
        coinDataService.$allCoins
            .subscribe(on: DispatchQueue.global(qos: .default))
            .sink { [weak self] returnedCoins in
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
}

