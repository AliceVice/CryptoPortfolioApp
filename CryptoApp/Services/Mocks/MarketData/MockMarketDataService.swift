//
//  MockMarketDataService.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 10/03/2025.
//

import Foundation


// Replace `MarketDataModel` with the name of your actual market data model type.
class MockMarketDataService: ObservableObject {
    @Published var marketData: MarketData? = nil
    
    init() {
        loadMockData()
    }
    
    private func loadMockData() {
        // Make sure "market_data.json" is in your app bundle
        // (e.g., in the Mock folder and included under Build Phases > Copy Bundle Resources).
        guard let url = Bundle.main.url(forResource: "market_data", withExtension: "json") else {
            print("Could not find market_data.json in the app bundle.")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decodedData = try JSONDecoder().decode(GlobalMarketData.self, from: data)
            self.marketData = decodedData.data
            print("loaded market data from \(type(of: self))")
        } catch {
            print("Error decoding market_data.json: \(error)")
        }
    }
}


