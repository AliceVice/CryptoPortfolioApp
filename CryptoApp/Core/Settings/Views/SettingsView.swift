//
//  SettingsView.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 12/03/2025.
//

import SwiftUI

struct SettingsView: View {
    
    let defaultURL = URL(string: "https://www.google.com")!
    let youtubeURL = URL(string: "https://www.youtube.com/@SwiftfulThinking")!
    let coffeeURL = URL(string: "https://buymeacoffee.com/nicksarno")!
    let coingeckoURL = URL(string: "https://www.coingecko.com/")!
    let githubURL = URL(string: "https://github.com/AliceVice")!
    
    var body: some View {
        NavigationStack {
            List {
                swiftFulThinkingSection
                coinGeckoSection
                developerSection
                applicationSection
            }
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

#Preview {
    NavigationStack {
        SettingsView()
    }
}


extension SettingsView {
    private var swiftFulThinkingSection: some View {
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
            
            Link("Subscribe to Nick 🥳", destination: youtubeURL)
            Link("Support his coffee addiction ☕️", destination: youtubeURL)
        } header: {
            Text("Swiftful Thinking")
        }
    }
    
    private var coinGeckoSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("coingecko")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    .clipShape(.rect(cornerRadius: 10))
                
                Text("The cryptocurrency data that is used in this app comes from a free API provided by CoinGecko 🐸! Prices may be slightly delayed. ")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            
            Link("Visit coingecko 🌍", destination: coingeckoURL)
        } header: {
            Text("Coingecko")
        }
    }
    
    private var developerSection: some View {
        Section {
            VStack(alignment: .leading) {
                Image("water_drops")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(.rect(cornerRadius: 10))
                
                Text("I want to say thanks to Nick Sarno. He is such a great teacher. Thanks to him, my knowledge of SwiftUI has skyrocketed 🚀! I have experienced how to work with Combine, Core Data, Multi-Threading and MVVM architecture 🧩.")
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.theme.accent)
            }
            .padding(.vertical)
            Link("My github 🐙", destination: githubURL)
        } header: {
            Text("Developer")
        }
    }
    
    private var applicationSection: some View {
        Section {
            Link("Terms of Service", destination: defaultURL)
            Link("Privacy Policy", destination: defaultURL)
            Link("Company Website", destination: defaultURL)
            Link("Learn More", destination: defaultURL)
        } header: {
            Text("Application")
        }
    }
    
}

