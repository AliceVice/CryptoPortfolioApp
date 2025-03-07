//
//  CoinImageService.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 07/03/2025.
//

import Foundation
import SwiftUI
import Combine

final class CoinImageService {
    
    @Published var image: UIImage? = nil
    
    private var imageSubscription: AnyCancellable?
    private let coin: Coin
    
    public init(coin: Coin) {
        self.coin = coin
        getCoinImage()
    }
    
    private func getCoinImage() {

        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] receivedImage in
                self?.image = receivedImage
                self?.imageSubscription?.cancel()
            })
    }
}
