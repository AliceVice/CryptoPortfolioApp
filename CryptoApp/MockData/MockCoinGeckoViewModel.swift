//
//  MockCoinGeckoViewModel.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 06/03/2025.
//

import Foundation


class MockCoinGeckoViewModel: ObservableObject {
    @Published var coins: [MockCoin] = []
    
    func fetchCoins() {
        let baseURL = "https://api.coingecko.com/api/v3/coins/markets"
        let queryItems = [
            URLQueryItem(name: "vs_currency", value: "usd"),
            URLQueryItem(name: "order", value: "market_cap_desc"),
            URLQueryItem(name: "per_page", value: "250"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "sparkline", value: "false")
        ]
        
        var urlComponents = URLComponents(string: baseURL)!
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil,
                  let data = data,
                  let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode
            else {
                print("Error fetching coins: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let decodedCoins = try JSONDecoder().decode([MockCoin].self, from: data)
                DispatchQueue.main.async {
                    self.coins = decodedCoins
                }
            } catch {
                print("Error decoding coin data: \(error)")
            }
            
            
            
        }.resume()
    }
}
