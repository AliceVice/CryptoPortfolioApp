//
//  CoinModel.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 06/03/2025.
//

import Foundation



struct Coin: Identifiable, Decodable {
    let id: String
    let symbol: String
    let name: String
    let image: String
    let currentPrice: Double
    let marketCap: Double?
    let marketCapRank: Int?
    let fullyDilutedValuation: Double?
    let totalVolume: Double?
    let high24h: Double?
    let low24h: Double?
    let priceChange24h: Double?
    let priceChangePercentage24h: Double?
    let marketCapChange24h: Double?
    let marketCapChangePercentage24h: Double?
    let circulatingSupply: Double?
    let totalSupply: Double?
    let maxSupply: Double?
    let ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl: Double?
    let atlChangePercentage: Double?
    let atlDate: String?
    let lastUpdated: String?
    let sparklineIn7d: SparklineIn7d?
    let priceChangePercentage24hInCurrency: Double?
    let currentHoldings: Double?
    
    var currentHoldingsValue: Double {
        return (currentHoldings ?? 0) * currentPrice
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case symbol
        case name
        case image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24h = "high_24h"
        case low24h = "low_24h"
        case priceChange24h = "price_change_24h"
        case priceChangePercentage24h = "price_change_percentage_24h"
        case marketCapChange24h = "market_cap_change_24h"
        case marketCapChangePercentage24h = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case lastUpdated = "last_updated"
        case sparklineIn7d = "sparkline_in_7d"
        case priceChangePercentage24hInCurrency = "price_change_percentage_24h_in_currency"
        case currentHoldings
    }
}

struct SparklineIn7d: Codable {
    let price: [Double]?
}


extension Coin {
    /// Returns a new instance of Coin with currentHoldings set up
    public func setHoldings(to amount: Double) -> Coin {
        // Use the memberwise initializer to create a copy,
        // but override currentHoldings.
        Coin(
            id: id, symbol: symbol, name: name, image: image,
            currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank,
            fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24h: high24h,
            low24h: low24h, priceChange24h: priceChange24h, priceChangePercentage24h: priceChangePercentage24h,
            marketCapChange24h: marketCapChange24h, marketCapChangePercentage24h: marketCapChangePercentage24h,
            circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply,
            ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl,
            atlChangePercentage: atlChangePercentage, atlDate: atlDate, lastUpdated: lastUpdated,
            sparklineIn7d: sparklineIn7d, priceChangePercentage24hInCurrency: priceChangePercentage24hInCurrency,
            currentHoldings: amount
        )
    }
    
    /// Returns a mock coin for Preview use purposes
    static let previewCoin = Coin(
        id: "ethereum",
        symbol: "eth",
        name: "Ethereum",
        image: "https://coin-images.coingecko.com/coins/images/279/large/ethereum.png?1696501628",
        currentPrice: 2247.73,
        marketCap: 272074560894,
        marketCapRank: 2,
        fullyDilutedValuation: 272074560894,
        totalVolume: 20562212382,
        high24h: 2317.43,
        low24h: 2168.29,
        priceChange24h: 63.08,
        priceChangePercentage24h: 2.88739,
        marketCapChange24h: 7663235971,
        marketCapChangePercentage24h: 2.89823,
        circulatingSupply: 120594948.925222,
        totalSupply: 120594948.925222,
        maxSupply: nil,
        ath: 4878.26,
        athChangePercentage: -54.44211,
        athDate: "2021-11-10T14:24:19.604Z",
        atl: 0.432979,
        atlChangePercentage: 513188.93075,
        atlDate: "2015-10-20T00:00:00.000Z",
        lastUpdated: "2025-03-06T15:12:10.739Z",
        sparklineIn7d: SparklineIn7d(price: [2352.10319364983, 2343.65490657594, 2337.50428472527]),
        priceChangePercentage24hInCurrency: 2.88738829935313,
        currentHoldings: nil
    )
}



// JSON RESPONSE:
/*
 {
     "id": "ethereum",
     "symbol": "eth",
     "name": "Ethereum",
     "image": "https://coin-images.coingecko.com/coins/images/279/large/ethereum.png?1696501628",
     "current_price": 2247.73,
     "market_cap": 272074560894,
     "market_cap_rank": 2,
     "fully_diluted_valuation": 272074560894,
     "total_volume": 20562212382,
     "high_24h": 2317.43,
     "low_24h": 2168.29,
     "price_change_24h": 63.08,
     "price_change_percentage_24h": 2.88739,
     "market_cap_change_24h": 7663235971,
     "market_cap_change_percentage_24h": 2.89823,
     "circulating_supply": 120594948.925222,
     "total_supply": 120594948.925222,
     "max_supply": null,
     "ath": 4878.26,
     "ath_change_percentage": -54.44211,
     "ath_date": "2021-11-10T14:24:19.604Z",
     "atl": 0.432979,
     "atl_change_percentage": 513188.93075,
     "atl_date": "2015-10-20T00:00:00.000Z",
     "roi": {
       "times": 32.1636546965109,
       "currency": "btc",
       "percentage": 3216.36546965109
     },
     "last_updated": "2025-03-06T15:12:10.739Z",
     "sparkline_in_7d": {
       "price": [2352.10319364983, 2343.65490657594, 2337.50428472527]
     },
     "price_change_percentage_24h_in_currency": 2.88738829935313
   }
 */

