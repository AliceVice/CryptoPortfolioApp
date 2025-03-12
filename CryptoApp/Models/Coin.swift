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
    let currentHoldingsAmount: Double?
    
    var currentHoldingsValue: Double {
        return (currentHoldingsAmount ?? 0) * currentPrice
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
        case currentHoldingsAmount
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
            currentHoldingsAmount: amount
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
        sparklineIn7d: SparklineIn7d(price: [2180.47818776271, 2197.06347909677, 2208.17840175514, 2213.40433464884, 2243.12522852616, 2238.49372129323, 2219.57458557119, 2216.32897047231, 2202.76239582018, 2187.21324620201, 2184.74375123294, 2181.34415610927, 2191.38067445274, 2205.18235407393, 2217.84007121633, 2230.58451807048, 2236.76663555967, 2239.43573566817, 2244.93543156781, 2239.38525396637, 2276.67668152968, 2285.53409620509, 2291.0495263474, 2298.49071295331, 2293.46798053731, 2284.96039222216, 2294.55317884117, 2285.49469369194, 2286.94468973737, 2296.03784483042, 2270.40772461445, 2245.09354286701, 2235.83223471958, 2262.01886632793, 2206.57307502723, 2193.51467151705, 2198.53583529312, 2211.59788837293, 2202.95874206825, 2210.85785573639, 2217.76091250128, 2207.83443389444, 2119.31912561697, 2174.7055588482, 2157.31180403096, 2150.00566454196, 2157.62861846849, 2177.33316358494, 2182.83737282261, 2190.36808188554, 2186.10081276486, 2194.18230164163, 2195.10542332319, 2192.74335933697, 2181.73923946306, 2188.99869140124, 2228.26797662863, 2206.95548783249, 2157.35469640673, 2171.09016489942, 2192.31187607525, 2172.31384257584, 2154.56456851514, 2139.06698913314, 2142.25897434132, 2139.36588168872, 2148.99224649659, 2128.50132315601, 2142.90653113847, 2137.11076583009, 2150.7478948011, 2140.48134983244, 2138.7457311143, 2134.66304436481, 2132.32466610117, 2127.80267358488, 2138.96926041651, 2144.77719470095, 2168.01364544081, 2189.86629977252, 2179.23786417403, 2181.57838390955, 2187.65303849174, 2201.25673500799, 2208.71997623306, 2222.16622125336, 2215.09337617755, 2215.57387170366, 2206.24356736639, 2201.45820919892, 2207.29496173732, 2192.96134451102, 2181.82745403788, 2185.35323899116, 2188.61105232695, 2181.79992968991, 2181.19561303736, 2184.45737882995, 2176.63541417619, 2163.23520406241, 2135.91795257146, 2147.99210590167, 2140.03155126538, 2105.12347176967, 2117.52149051558, 2088.85441425174, 2056.03133289797, 2025.66039137005, 2020.13923940881, 2042.61941242728, 2044.33118738861, 2020.24680950217, 2007.59843863332, 2030.72204229924, 2036.59368066733, 2039.24115100129, 2056.32641597075, 2063.79374374318, 2073.28902558097, 2066.33406525249, 2067.01059090966, 2074.03999443591, 2060.60006672875, 2101.94380266378, 2103.50177560386, 2138.00546985433, 2124.7396587806, 2053.16620980459, 2002.4139131806, 2019.75122631985, 2010.22576951755, 1923.27530125768, 1840.49280363465, 1868.3831442915, 1872.07088729812, 1886.13401314543, 1880.12341908544, 1867.86771948349, 1813.20780699993, 1853.96120014171, 1861.18330183905, 1854.18329564537, 1869.24071491409, 1893.19796865603, 1888.00917468588, 1904.55537110876, 1908.57453453969, 1917.85761696475, 1922.90382185296, 1908.87589958235, 1894.44933815415, 1903.40891346461, 1879.05315411333, 1914.50446194996, 1915.90100919777, 1905.14965476826, 1949.38201157337, 1948.40425122764, 1937.94783757373, 1940.77062286276, 1945.39312529034, 1916.68235553753, 1911.19691252246, 1921.34202841466, 1892.46368734586, 1861.08725416377, 1864.99242045995]),
        priceChangePercentage24hInCurrency: 2.88738829935313,
        currentHoldingsAmount: 2.5
    )
}



/*
 
 URL:
  
    https://api.coingecko.com/api/v3/coins/markets
    ?vs_currency=usd
    &order=market_cap_desc
    &per_page=250
    &page=1
    &sparkline=true
    &price_change_percentage=24h
     

 JSON RESPONSE:

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

