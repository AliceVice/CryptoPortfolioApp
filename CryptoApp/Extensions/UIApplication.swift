//
//  UIApplication.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 08/03/2025.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
