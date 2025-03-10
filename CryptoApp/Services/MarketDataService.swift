//
//  MarketDataService.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 09/03/2025.
//

import Foundation
import Combine

final class MarketDataService {
    
    @Published public var marketData: MarketData? = nil
    private var marketDataSubscription: AnyCancellable?
    
    public init() {
        getMarketData()
    }
    
    private func getMarketData() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/global") else { return }
        
        marketDataSubscription = NetworkManager.download(url: url)
            .decode(type: GlobalMarketData.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] returnedGlobalData in
                self?.marketData = returnedGlobalData.data
                self?.marketDataSubscription?.cancel()
            })
        
    }
    
}
