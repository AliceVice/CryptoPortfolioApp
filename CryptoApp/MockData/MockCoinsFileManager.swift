//
//  MockCoinsFileManager.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 06/03/2025.
//

import Foundation


class CoinsFileManager {
    
    /// Downloads the coins JSON data from CoinGecko and saves it to a file.
    /// - Parameter completion: A closure that receives a Bool indicating success.
    static func downloadAndSaveCoins(completion: @escaping (Bool) -> Void) {
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
        
        guard let url = urlComponents.url else {
            print("Invalid URL")
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil,
                  let data = data,
                  let httpResponse = response as? HTTPURLResponse,
                  200..<300 ~= httpResponse.statusCode
            else {
                print("Error downloading coins: \(error?.localizedDescription ?? "Unknown error")")
                completion(false)
                return
            }
            
            // Save the data to a file in the Documents directory.
            do {
                let documentsDirectory = try FileManager.default.url(for: .documentDirectory,
                                                                     in: .userDomainMask,
                                                                     appropriateFor: nil,
                                                                     create: true)
                let fileURL = documentsDirectory.appendingPathComponent("coins.json")
                try data.write(to: fileURL, options: .atomic)
                print("Coins JSON saved at: \(fileURL.path)")
                completion(true)
            } catch {
                print("Error saving file: \(error.localizedDescription)")
                completion(false)
            }
            
        }.resume()
    }
}
