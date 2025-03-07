//
//  TestApiView.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 06/03/2025.
//

import SwiftUI



struct TestApiView: View {
    @StateObject var viewModel = MockCoinGeckoViewModel()
    
    var body: some View {
        NavigationStack {
            List(viewModel.coins) { coin in
                HStack {
                    AsyncImage(url: URL(string: coin.image)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    } placeholder: {
                        ProgressView()
                    }
                    
                    VStack(alignment: .leading) {
                        Text(coin.name)
                            .font(.headline)
                        Text("Symbol: \(coin.symbol.uppercased())")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Text("$\(coin.current_price, specifier: "%.2f")")
                        .font(.headline)
                }
            }
            .navigationTitle("CoinGecko Markets")
            .onAppear {
//                viewModel.fetchCoins()
                CoinsFileManager.downloadAndSaveCoins { success in
                    if success {
                        print("Download and save succeeded.")
                    } else {
                        print("Download or save failed.")
                    }
                }
            }
        }
    }
}

//#Preview {
//    TestApiView()
//}


