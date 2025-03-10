//
//  CoinLogoView.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 10/03/2025.
//

import SwiftUI

struct CoinLogoView: View {
    
    let coin: Coin
    
    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 60, height: 60)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
            Text(coin.name)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .lineLimit(2)
                .minimumScaleFactor(0.5)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinLogoView(coin: Coin.previewCoin)
        .preferredColorScheme(.dark)
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinLogoView(coin: Coin.previewCoin)
        .preferredColorScheme(.light)
}
