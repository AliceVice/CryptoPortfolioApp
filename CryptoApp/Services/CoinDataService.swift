//
//  NetworkService.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 07/03/2025.
//

import Foundation
import Combine

final class CoinDataService {
    
    @Published public var allCoins: [Coin] = []
    private var coinSubscription: AnyCancellable?
    
    public init() {
        getCoins()
    }
    
    private func getCoins() {
        guard let url = URL(string:
            "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")
        else { return }
        
        coinSubscription = NetworkManager.download(url: url)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] receivedCoins in
                self?.allCoins = receivedCoins
                self?.coinSubscription?.cancel()
            })
        
    }
    
}

