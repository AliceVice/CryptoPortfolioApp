//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 09/03/2025.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var selectedCoin: Coin? = nil
    @State private var quantityText: String = ""
    @State private var showCheckMark: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    SearchBarView(searchText: $viewModel.searchText)
                    
                    coinLogoList
                    
                    if let _ = selectedCoin {
                        portfolioInputSection
                    }
                    
                }
            }
            .background(
                Color.theme.background
            )
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    saveButton
                }
            }
            .onChange(of: viewModel.searchText) { oldValue, newValue in
                if newValue == "" {
                    removeSelectedCoin()
                }
            }
        }
    }
}

#Preview {
    PortfolioView()
        .environmentObject(HomeViewModel.preview)
}

extension PortfolioView {
    
    private var coinLogoList: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 10) {
                ForEach(viewModel.searchText.isEmpty ?
                        viewModel.portfolioCoins : viewModel.shownCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 80, height: 120)
                        .padding(4)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(
                                    selectedCoin?.id == coin.id ? Color.theme.green : .clear
                                    , lineWidth: 1)
                        )
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        }
        .scrollIndicators(.hidden)
    }
    
    private func updateSelectedCoin(coin: Coin) {
        selectedCoin = coin
        
        if let portfolioCoin = viewModel.portfolioCoins.first(where: { $0.id == coin.id }),
           let amount = portfolioCoin.currentHoldingsAmount
        {
            quantityText = "\(amount)"
        } else {
            quantityText = ""
        }
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""): ")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "0.00")
            }
            
            Divider()
            
            HStack {
                Text("Add to Portfolio")
                Spacer()
                TextField("Ex: 2.3", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
                    .onChange(of: quantityText) { _, newValue in
                        quantityText = newValue.replacingOccurrences(of: ",", with: ".")
                    }
            }
            
            Divider()
            
            HStack {
                Text("Current value:")
                
                Spacer()
                
                Text(getCurrentValue().asCurrencyWith2Decimals())
            }
        }
        .padding()
        .font(.headline)
        .animation(.none, value: selectedCoin?.symbol)
    }
    
    private var saveButton: some View {
        HStack {
            Image(systemName: "checkmark")
                .foregroundStyle(Color.theme.green)
                .opacity(showCheckMark ? 1 : 0)
            
            Button(action: {
                saveButtonPressed()
            }, label: {
                Text("Save".uppercased())
            })
            .opacity(
                (selectedCoin != nil && !quantityText.isEmpty &&
                 selectedCoin?.currentHoldingsAmount != Double(quantityText)) ?
                1 : 0
            )
        }
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText) {
            return quantity * (selectedCoin?.currentPrice ?? 0)
        } else {
            return 0
        }
    }
    
    private func saveButtonPressed() {
        
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
        else { return }
        
        // save the portfolio
        viewModel.updatePortfolio(coin: coin, amount: amount)
        
        // show checkmark
        withAnimation(.easeIn) {
            showCheckMark = true
        }
        
        // remove selected coin
        removeSelectedCoin()
        
        // hide keyboard
        UIApplication.shared.endEditing()
        
        // hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation(.easeOut) {
                showCheckMark = false
            }
        }
    }
    
    private func removeSelectedCoin() {
        withAnimation(.easeOut) {
            selectedCoin = nil
            quantityText = ""
            viewModel.searchText = ""
        }
    }
}
