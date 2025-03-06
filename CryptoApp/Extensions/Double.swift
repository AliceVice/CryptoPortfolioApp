//
//  Double.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 06/03/2025.
//

import Foundation

extension Double {
    
    /// Convert a Double into a Currency with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to $1234.56
    /// Convert 12.3456 to $12.3456
    /// Convert 0.123456 to $0.123456
    ///
    /// ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
//        formatter.locale = .current // <- default value
        formatter.currencyCode = "usd" // <- change currency
        formatter.currencySymbol = "$" // <- change currency symbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// Convert a Double into a Currency as a String with 2-6 decimal places
    /// ```
    /// Convert 1234.56 to "$1234.56"
    /// Convert 12.3456 to "$12.3456"
    /// Convert 0.123456 to "$0.123456"
    ///
    /// ```
    public func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "0.00 $"
    }
    
}
