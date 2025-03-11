//
//  DetailViewModel.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 11/03/2025.
//

import Foundation
import Combine

final class DetailViewModel: ObservableObject {
    
    @Published var coinDetail: CoinDetail? = nil
    private let coinDetailService: CoinDetailDataService
    private var cancellables: Set<AnyCancellable> = []
    
    public init(coin: Coin) {
        coinDetailService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
        
    private func addSubscribers() {
        coinDetailService.$coinDetail
            .sink { returnedCoinDetail in
                print(String(describing: returnedCoinDetail))
                self.coinDetail = returnedCoinDetail
            }
            .store(in: &cancellables)
    }
}
