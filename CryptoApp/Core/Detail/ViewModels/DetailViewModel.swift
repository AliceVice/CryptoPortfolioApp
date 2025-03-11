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
    @Published var overviewStatistics: [Statistic] = []
    @Published var additionalStatistics: [Statistic] = []
    @Published var coin: Coin
    
    private let coinDetailService: CoinDetailDataService
    private var cancellables: Set<AnyCancellable> = []
    
    public init(coin: Coin) {
        self.coin = coin
        coinDetailService = CoinDetailDataService(coin: coin)
        addSubscribers()
    }
        
    private func addSubscribers() {
        coinDetailService.$coinDetail
            .combineLatest($coin)
            .map({ [weak self] coinDetail, coin -> (overview: [Statistic], additional: [Statistic]) in
                guard let self else { return ([], []) }
                
                let overviewStats = self.makeOverviewStats(coin: coin)
                let additionalStats = self.makeAdditionalStats(coin: coin, coinDetail: coinDetail)
                
                return (overviewStats, additionalStats)
            })
            .sink { [weak self] returnedStatisticArrays in
                guard let self else { return }
                self.overviewStatistics = returnedStatisticArrays.overview
                self.additionalStatistics = returnedStatisticArrays.additional
            }
            .store(in: &cancellables)
    }
    
    private func makeOverviewStats(coin: Coin) -> [Statistic] {
        // Current price
        let price = coin.currentPrice.asCurrencyWith6Decimals()
        let pricePercChange1 = coin.priceChangePercentage24h
        let priceStat = Statistic(title: "Current price", value: price, percentageChange: pricePercChange1)
        
        // Market Capitalization
        let marketCap = "$" + (coin.marketCap?.formattedWithAbbreviations() ?? "")
        let marketCapPercChange1 = coin.marketCapChangePercentage24h
        let marketCapStat = Statistic(title: "Market Capitalization", value: marketCap, percentageChange: marketCapPercChange1)
        
        // Rank
        let rank = "\(coin.rank)"
        let rankStat = Statistic(title: "Rank", value: rank)
        
        // Volume
        let volume = "$" + (coin.totalVolume?.formattedWithAbbreviations() ?? "")
        let volumeStat = Statistic(title: "Volume", value: volume)
        
        return [priceStat, marketCapStat, rankStat, volumeStat]
    }
    
    private func makeAdditionalStats(coin: Coin, coinDetail: CoinDetail?) -> [Statistic] {
        // 24H High
        let high = coin.high24h?.asCurrencyWith6Decimals() ?? "n/a"
        let highStat = Statistic(title: "24h High", value: high)
        
        // 24H Low
        let low = coin.low24h?.asCurrencyWith6Decimals() ?? "n/a"
        let lowStat = Statistic(title: "24h Low", value: low)
        
        // 24h Price Change
        let priceChange = coin.priceChange24h?.asCurrencyWith6Decimals() ?? "n/a"
        let pricePercChange2 = coin.priceChangePercentage24h
        let priceChangeStat = Statistic(title: "24h Price Change", value: priceChange, percentageChange: pricePercChange2)
        
        // 24h Market Cap Change
        let marketCapChange = "$" + (coin.marketCapChange24h?.formattedWithAbbreviations() ?? "")
        let marketCapPercentChange2 = coin.marketCapChangePercentage24h
        let marketCapChangeStat = Statistic(title: "24h Market Cap Change", value: marketCapChange, percentageChange: marketCapPercentChange2)
        
        // Block Time
        let blockTime = coinDetail?.blockTimeInMinutes ?? 0
        let blockTimeString = blockTime == 0 ? "n/a" : "\(blockTime)"
        let blockStat = Statistic(title: "Block Time", value: blockTimeString)
        
        // Hashing
        let hashingAlgorithm = coinDetail?.hashingAlgorithm ?? "n/a"
        let hashingAlgorithmStat = Statistic(title: "Hashing Algorithm", value: hashingAlgorithm)
        
        return [highStat, lowStat, priceChangeStat, marketCapChangeStat, blockStat, hashingAlgorithmStat]
    }
    
}
