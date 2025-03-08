//
//  HomeView.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 06/03/2025.
//

import SwiftUI

// Endpoint
/*
 https://api.coingecko.com/api/v3/coins/markets
 ?vs_currency=usd
 &order=market_cap_desc
 &per_page=250
 &page=1
 &sparkline=true
 &price_change_percentage=24h
 */

struct HomeView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()
            
            // content layer
            VStack {
                navigationView
                
                SearchBarView(searchText: $viewModel.searchText)
                
                titlesView
                
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                
                if showPortfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
            
        }
    }
}


#Preview {
    NavigationStack {
        HomeView()
            .toolbar(.hidden)
    }
    .environmentObject(HomeViewModel.preview)
}


extension HomeView {
    private var navigationView: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info")
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
                .animation(.none, value: showPortfolio)
            
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundStyle(Color.theme.accent)
                .animation(.none, value: showPortfolio)
            
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(
                    Angle(degrees: showPortfolio ? 180 : 0)
                )
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinsList: some View {
        List(viewModel.shownCoins) { coin in
            CoinRowView(coin: coin, showHoldingsColumn: showPortfolio)
                .listRowInsets(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
        .listStyle(.plain)
    }
    
    private var portfolioCoinsList: some View {
        List(viewModel.portfolioCoins) { portfolioCoin in
            CoinRowView(coin: portfolioCoin, showHoldingsColumn: showPortfolio)
                .listRowInsets(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
        .listStyle(.plain)
    }
    
    private var titlesView: some View {
        HStack(spacing: 0) {
            Text("Coin")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: (UIScreen.current?.bounds.width ?? 120) / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal, 10)
    }
}


