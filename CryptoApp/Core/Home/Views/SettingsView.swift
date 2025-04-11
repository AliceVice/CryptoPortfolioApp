//
//  SettingsView.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 12/03/2025.
//

import SwiftUI

struct SettingsView: View {
    
    private let githubProjectLink = URL(string: "https://github.com/AliceVice/Forecastly")
    private let coingeckoApiURL = URL(string: "https://open-meteo.com/")!
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                // Background layer
                Color.theme.background
                    .ignoresSafeArea()
                
                // Content layer
                List {
                    Group {
                        projectSection
                        coinGeckoApiSection
                    }
                    .listRowBackground(Color.theme.secondaryText.opacity(0.2))
                }
                .scrollContentBackground(.hidden)
                .font(.headline)
                .tint(.blue)
                .listStyle(.grouped)
                .navigationTitle("Settings")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        XMarkButton()
                    }
                }
            }
        }
    }
    
}

#Preview {
    NavigationStack {
        SettingsView()
    }
}


extension SettingsView {
    private var projectSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("logo")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(.rect(cornerRadius: 10))
                
                Text("This App was made by following a @SwiftfulThinking cource on youtube. It uses MVVM Architecture, Combine and Core Data")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            
            if let githubProjectLink {
                Link("Github link to the project", destination: githubProjectLink)
            }
            
        } header: {
            Text("Swiftful Thinking")
        }
    }
    
    private var coinGeckoApiSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(.rect(cornerRadius: 10))
                
                Text("The cryptocurrency data that is used in this app comes from a free API provided by CoinGecko! Prices may be slightly delayed.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            
            Link("Visit coingecko 🌍", destination: coingeckoApiURL)
        } header: {
            Text("Coingecko")
        }
    }
    
}

