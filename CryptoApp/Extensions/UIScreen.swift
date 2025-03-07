//
//  UIScreen.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 07/03/2025.
//

import UIKit



extension UIWindow {
    
    /// Returns the current key window from the connected scenes.
    static var current: UIWindow? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows {
                if window.isKeyWindow { return window }
            }
        }
        return nil
    }
}


extension UIScreen {
    
    /// Returns the screen associated with the current key window.
    static var current: UIScreen? {
        UIWindow.current?.screen
    }
}

