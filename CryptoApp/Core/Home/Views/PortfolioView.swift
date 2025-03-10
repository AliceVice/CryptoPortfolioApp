//
//  PortfolioView.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 09/03/2025.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
//            ScrollView {
//                VStack(alignment: .leading, spacing: 0) {
//                    SearchBarView(searchText: $viewModel.searchText)
//                }
//                
//                ScrollView(.horizontal) {
//                    LazyHStack(spacing: 10) {
//                        ForEach(viewModel.shownCoins) { coin in
//                            
//                        }
//                    }
//                }
//                .scrollIndicators(.visible)
//                
//            }
//            .navigationTitle("Edit Portfolio")
//            .toolbar {
//                ToolbarItem(placement: .topBarLeading) {
//                    XMarkButton()
//                }
//            }
        }
    }
}

#Preview {
    PortfolioView()
        .environmentObject(HomeViewModel.preview)
}
