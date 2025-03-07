//
//  CoinRowView.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 06/03/2025.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: Coin
    let showHoldingsColumn: Bool
    
    var body: some View {
        HStack(spacing: 0) {
            
            leftColumn
            
            Spacer()
            
            if showHoldingsColumn { centerColumn }
            
            rightColumn
        }
        .font(.subheadline)
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinRowView(coin: Coin.previewCoin, showHoldingsColumn: true)
        .preferredColorScheme(.light)
}

#Preview(traits: .sizeThatFitsLayout) {
    CoinRowView(coin: Coin.previewCoin, showHoldingsColumn: true)
        .preferredColorScheme(.dark)
}



extension CoinRowView {
    private var leftColumn: some View {
        HStack(spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
                .frame(minWidth: 30)
            
            Circle()
                .frame(width: 30, height: 30)
            
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundStyle(Color.theme.accent)
        }
    }
    
    private var centerColumn: some View {
        VStack(alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundStyle(Color.theme.accent)
    }
    
    private var rightColumn: some View {
        VStack(alignment: .trailing) {
            Text("\(coin.currentPrice.asCurrencyWith6Decimals())")
                .bold()
                .foregroundStyle(Color.theme.accent)
            Text(coin.priceChangePercentage24h?.asPersentString() ?? "")
                .bold()
                .foregroundStyle(
                    (coin.priceChangePercentage24h ?? 0.0) >= 0 ?
                    Color.theme.green : Color.theme.red
                )
        }
        .frame(width: (UIScreen.current?.bounds.width ?? 120) / 3.5, alignment: .trailing)
    }
}
