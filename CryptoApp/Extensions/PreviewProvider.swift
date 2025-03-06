//
//  PreviewProvider.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 06/03/2025.
//

import SwiftUI


extension PreviewProvider {
    
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}


final class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    
    private init() {
        
    }
       
}

