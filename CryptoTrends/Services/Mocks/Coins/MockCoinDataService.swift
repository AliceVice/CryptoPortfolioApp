//
//  MockDataManager.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 10/03/2025.
//

import Foundation


// Replace `CoinModel` with the name of your coin model type.
class MockCoinDataService: ObservableObject {
    @Published var allCoins: [Coin] = []
    
    init() {
        getCoins()
    }
    
    public func getCoins() {
        // Ensure 'coins.json' is included in your app bundle (e.g., Build Phases > Copy Bundle Resources).
        guard let url = Bundle.main.url(forResource: "coins", withExtension: "json") else {
            print("Could not find coins.json in the app bundle.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedCoins = try JSONDecoder().decode([Coin].self, from: data)
            self.allCoins = decodedCoins
            print("loaded coins from from \(type(of: self))")
        } catch {
            print("Error decoding coins.json: \(error)")
        }
    }
}

