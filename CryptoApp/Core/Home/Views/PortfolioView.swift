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
            .navigationTitle("Edit Portfolio")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    XMarkButton()
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    saveButton
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
                ForEach(viewModel.shownCoins) { coin in
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
                                selectedCoin = coin
                            }
                        }
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        }
        .scrollIndicators(.hidden)
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
                (selectedCoin != nil &&
                 selectedCoin?.currentHoldings != Double(quantityText)) ?
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
//        guard let selectedCoin else { return }
        
        // save the portfolio
         
        // show checkmark and remove selected coin
        withAnimation(.easeIn) {
            showCheckMark = true
            removeSelectedCoin()
        }
        
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
        selectedCoin = nil
        quantityText = ""
        viewModel.searchText = ""
    }
}
