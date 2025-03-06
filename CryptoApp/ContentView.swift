//
//  ContentView.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 05/03/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            
            Color.theme.background
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Accent Color")
                    .foregroundStyle(Color.theme.accent)
                
                Text("Secondary Text Color")
                    .foregroundStyle(Color.theme.secondaryText)
                
                Text("Red Color")
                    .foregroundStyle(Color.theme.red)
                
                Text("Green Color")
                    .foregroundStyle(Color.theme.green)
                
                .foregroundStyle(.accent)
            }
            .font(.headline)
            
        }
    }
}

#Preview {
    ContentView()
}
