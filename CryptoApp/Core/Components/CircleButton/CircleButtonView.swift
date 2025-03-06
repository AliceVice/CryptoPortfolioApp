//
//  CircleButtonView.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 06/03/2025.
//

import SwiftUI

struct CircleButtonView: View {
    
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundStyle(Color.theme.accent)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundStyle(Color.theme.background)
            )
            .shadow(
                color: Color.theme.accent.opacity(0.5), radius: 10,
                x: 0, y: 0)
            .padding()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CircleButtonView(iconName: "info")
}

#Preview(traits: .sizeThatFitsLayout) {
    CircleButtonView(iconName: "plus")
}
