//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 05/03/2025.
//

import SwiftUI

@main
struct CryptoAppApp: App {
    
    @StateObject private var viewModel = HomeViewModel()
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.theme.accent)]
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView()
                    .toolbar(.hidden)
            }
            .environmentObject(viewModel)
        }
    }
}
