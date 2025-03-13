//
//  CoinDetailDataService.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 11/03/2025.
//

import SwiftUI
import Combine

final class CoinDetailDataService {
    
    @Published public var coinDetail: CoinDetail? = nil
    private var coinDetailSubscription: AnyCancellable?
    private let coin: Coin
    
    
    public init(coin: Coin) {
        self.coin = coin
        getCoin()
    }
    
    private func getCoin() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false")
        else { return }
        
        
        coinDetailSubscription = NetworkManager.download(url: url)
            .decode(type: CoinDetail.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] returnedCoinDetail in
                self?.coinDetail = returnedCoinDetail
                self?.coinDetailSubscription?.cancel()
            })
        
    }
    
}
