//
//  StatisticView.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 09/03/2025.
//

import SwiftUI

struct StatisticView: View {
    
    let stat: Statistic
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 4) {
            Text(stat.title)
                .font(.caption)
                .foregroundStyle(Color.theme.secondaryText)
            Text(stat.value)
                .font(.headline)
                .foregroundStyle(Color.theme.accent)
            
            HStack(spacing: 4) {
                Image(systemName: "triangle.fill")
                    .rotationEffect(
                        Angle(degrees: (stat.percentageChange ?? 0) >= 0 ? 0 : 180))
                
                Text(stat.percentageChange?.asPersentString() ?? "")
                    .bold()
            }
            .font(.caption)
            .foregroundStyle((stat.percentageChange ?? 0) >= 0 ? .green : .red)
            .opacity(stat.percentageChange == nil ? 0 : 1)
        }
        .padding()
        
    }
    
    /// A simple vertical stack of 10 text views.
    ///
    /// Unlike a `LazyVStack`, which only renders the views when needed,
    /// a `VStack` renders all its child views immediately.
    ///
    /// For more information, see [LazyVStack](https://developer.apple.com/documentation/swiftui/lazyvstack).
    func exampleVStack() -> some View {
        VStack(spacing: 10) {
            ForEach(0..<10) { index in
                Text("Item \(index)")
            }
        }
    }

}


#Preview(traits: .sizeThatFitsLayout) {
    StatisticView(stat: Statistic.previewStatistic1)
}

#Preview(traits: .sizeThatFitsLayout) {
    StatisticView(stat: Statistic.previewStatistic2)
}

#Preview(traits: .sizeThatFitsLayout) {
    StatisticView(stat: Statistic.previewStatistic3)
}
