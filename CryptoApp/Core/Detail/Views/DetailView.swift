//
//  DetailView.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 11/03/2025.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var viewModel: DetailViewModel
    
    init(coin: Coin) {
        self._viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
        print("Initializing Detail View for \(String(describing: coin.name))")
    }
    
    var body: some View {
        Text(viewModel.coinDetail?.name ?? "")
    }
}

#Preview {
    DetailView(coin: Coin.previewCoin)
}
