//
//  SettingsView.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 12/03/2025.
//

import SwiftUI

struct SettingsView: View {
    
    private let githubProjectLink = URL(string: "https://github.com/AliceVice/CryptoTrends")
    private let coingeckoApiURL = URL(string: "https://docs.coingecko.com/v3.0.1/reference/introduction")!
    
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
            HStack(alignment: .center, spacing: 16) {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .clipShape(.rect(cornerRadius: 10))
                
                Text("Crypto Trends")
                    .font(.title)
            }
            
            VStack(alignment: .leading, spacing: 16) {
                Text("This app is a cryptocurrency portfolio tracker. It uses modern technologies and architecture patterns:")
                    .font(.headline)
                
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("🎨")
                        Text("SwiftUI: For building the app’s user interface.")
                    }
                    
                    HStack {
                        Text("🚀")
                        Text("MVVM Architecture: For clear separation of concerns and maintainable code.")
                    }
                    
                    HStack {
                        Text("🧬")
                        Text("Combine: For handling asynchronous network calls and data binding between components.")
                    }
                    
                    HStack {
                        Text("📦")
                        Text("Core Data: For storing user's portfolio coins.")
                    }
                    
                    HStack {
                        Text("🗂️")
                        Text("FileManager: To store the images into the cache directory.")
                    }
                    
                    HStack {
                        Text("📈")
                        Text("CoinGecko API: To fetch real‑time cryptocurrency data.")
                    }
                }
            }
            .frame(maxWidth: .infinity)
            
            
            if let githubProjectLink {
                Link("Github link to the project", destination: githubProjectLink)
            }
            
        } header: {
            Text("Project")
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
            
            Link("Visit Coingecko 🌍", destination: coingeckoApiURL)
        } header: {
            Text("Coingecko")
        }
    }
    
}

