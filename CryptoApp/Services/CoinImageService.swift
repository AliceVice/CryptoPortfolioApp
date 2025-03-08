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
    
    private let fileManager = LocalFileManager.instance
    private let folderName: String = "coin_images"
    private let imageName: String
    
    private var imageSubscription: AnyCancellable?
    private let coin: Coin
    
    public init(coin: Coin) {
        self.coin = coin
        self.imageName = coin.id
        getCoinImage()
    }
    
    private func getCoinImage() {
        if let savedImage = fileManager.getImage(named: imageName, folderName: folderName) {
            image = savedImage
        } else {
            downloadCoinImage()
        }
    }
    
    private func downloadCoinImage() {
        guard let url = URL(string: coin.image) else { return }
        
        imageSubscription = NetworkManager.download(url: url)
            .tryMap({ data -> UIImage? in
                return UIImage(data: data)
            })
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] receivedImage in
                
                guard let self, let receivedImage else { return }
                
                self.image = receivedImage
                self.imageSubscription?.cancel()
                self.fileManager.save(image: receivedImage, in: self.folderName, as: self.imageName)
            })
    }
}

