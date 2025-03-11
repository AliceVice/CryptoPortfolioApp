//
//  HapticManager.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 11/03/2025.
//

import SwiftUI

final class HapticManager {
    static private let generator = UINotificationFeedbackGenerator()
    
    static func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        generator.notificationOccurred(type)
    }
}

