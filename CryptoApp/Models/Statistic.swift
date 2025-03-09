//
//  Statistic.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 09/03/2025.
//

import Foundation

struct Statistic: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
}


extension Statistic {
    
    /// Returns a mock `Statistic` without a `percentageChange` for preview use.
    static let previewStatistic1 = Statistic(title: "Total Volume", value: "$1.23Tr")
    
    /// Returns a mock `Statistic` with a positive `percentageChange` for preview use.
    static let previewStatistic2 = Statistic(title: "Market Cap",value: "$12.5Bn",percentageChange: 25.34)
    
    /// Returns a mock `Statistic` with a negative `percentageChange` for preview use.
    static let previewStatistic3 = Statistic(title: "Portfolio Values",value: "$50.4k",percentageChange: -14.67)
}

