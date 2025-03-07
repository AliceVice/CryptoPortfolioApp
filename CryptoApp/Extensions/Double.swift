//
//  Double.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 06/03/2025.
//

import Foundation

extension Double {
    
    /// Convert a Double into a Currency with 2 decimal places
    /// ```
    /// Convert:
    /// 12.3456 to $12.34
    /// ```
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US") // <- default value
//        formatter.currencyCode = "usd" // <- change currency
//        formatter.currencySymbol = "$" // <- change currency symbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    /// Convert a Double into a Currency with 2-6 decimal places
    /// ```
    /// Convert:
    /// 1234.56 to $1,234.56
    /// 12.3456 to $12.3456
    /// 0.1234567 to $0.123456
    /// ```
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US") // <- default value
//        formatter.currencyCode = "usd" // <- change currency
//        formatter.currencySymbol = "$" // <- change currency symbol
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    /// Convert a Double into a Currency as a String with 2 decimal places
    /// ```
    /// Convert:
    /// 12.3456 to "$12.34"
    /// ```
    public func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    /// Convert a Double into a Currency as a String with 2-6 decimal places
    /// ```
    /// Convert:
    /// 1234.56 to "$1,234.56"
    /// 12.3456 to "$12.3456"
    /// 0.1234567 to "$0.123456"
    /// ```
    public func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
    /// Convert a Double into String representation
    /// ```
    /// Convert:
    /// 243.4356 to "243,43"
    /// ```
    public func asNumberString() -> String {
        return String(format: "%.2f", self)
    }
    
    /// Convert a Double into String representation
    /// ```
    /// Convert:
    /// 87.4356 to "%87,43"
    /// ```
    public func asPersentString() -> String {
        return "%" + asNumberString()
    }
}

