//
//  Date.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 12/03/2025.
//

import Foundation

extension Date {
    
    // Coin gecko string: "2021-11-10T14:24:19.604Z"
    public init(coinGeckoString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinGeckoString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
    private var shortFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }
    
    public func asShortDateString() -> String {
        return shortFormatter.string(from: self)
    }
}
