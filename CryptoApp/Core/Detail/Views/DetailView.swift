//
//  DetailView.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 11/03/2025.
//

import SwiftUI

struct DetailView: View {
    
    let coin: Coin
    
    var body: some View {
        Text(coin.name)
    }
}

#Preview {
    DetailView(coin: Coin.previewCoin)
}
