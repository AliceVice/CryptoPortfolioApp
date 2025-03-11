//
//  HomeView.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 06/03/2025.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var showPortfolio: Bool = false // animate right
    @State private var showPortfolioView: Bool = false // new sheet
    @State private var selectedCoin: Coin? = nil
    @State private var showDetailView: Bool = false
    
    var body: some View {
        ZStack {
            // background layer
            Color.theme.background
                .ignoresSafeArea()
            
            // content layer
            VStack {
                
                // Navigation
                navigationView
                
                // Market Statistics
                HomeStatsView(showPortfolio: $showPortfolio)
                
                // Search bar
                SearchBarView(searchText: $viewModel.searchText)
                
                // Titles for the list
                columnTitles
                
                // Coins list
                if !showPortfolio {
                    allCoinsList
                        .transition(.move(edge: .leading))
                }
                
                // Portfolio List
                if showPortfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing))
                }
                
                Spacer(minLength: 0)
            }
        }
        .sheet(isPresented: $showPortfolioView) {
            PortfolioView()
        }
        .navigationDestination(isPresented: $showDetailView) {
            // We are 100% sure that selected coin has a value
            if let selectedCoin {
                DetailView(coin: selectedCoin)
            }
        }
    } // body
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
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
            
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
                .contentShape(Rectangle())
                .onTapGesture {
                    segue(coin: coin)
                }
        }
        .listStyle(.plain)
    }
    
    private func segue(coin: Coin) {
        selectedCoin = coin
        showDetailView = true
    }
    
    private var portfolioCoinsList: some View {
        List(viewModel.portfolioCoins) { portfolioCoin in
            CoinRowView(coin: portfolioCoin, showHoldingsColumn: showPortfolio)
                .listRowInsets(.init(top: 0, leading: 10, bottom: 0, trailing: 10))
        }
        .listStyle(.plain)
    }
    
    private var columnTitles: some View {
        HStack(spacing: 0) {
            
            HStack(spacing: 4) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .rank
                            || viewModel.sortOption == .rankReversed) ?
                            1 : 0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .rank ? 0 : 180 ))
            }
            .onTapGesture {
                withAnimation {
                    viewModel.sortOption = viewModel.sortOption == .rank ? .rankReversed : .rank
                }
            }
            
            
            Spacer()
            if showPortfolio {
                HStack(spacing: 4) {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((viewModel.sortOption == .holdings
                                || viewModel.sortOption == .holdingsReversed) ?
                                1 : 0)
                        .rotationEffect(Angle(degrees: viewModel.sortOption == .holdings ? 0 : 180 ))
                }
                .onTapGesture {
                    withAnimation {
                        viewModel.sortOption = viewModel.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                }
            }
            
            
            HStack(spacing: 4) {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .price
                            || viewModel.sortOption == .priceReversed) ?
                            1 : 0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .price ? 0 : 180 ))
            }
            .frame(width: (UIScreen.current?.bounds.width ?? 120) / 3.5, alignment: .trailing)
            .onTapGesture {
                withAnimation {
                    viewModel.sortOption = viewModel.sortOption == .price ? .priceReversed : .price
                }
            }
            
            Button {
                withAnimation(.linear(duration: 2.0)) {
                    viewModel.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: viewModel.isLoading ? 360 : 0), anchor: .center)
            .padding(.leading, 6)
            
        }
        .font(.caption)
        .foregroundStyle(Color.theme.secondaryText)
        .padding(.horizontal, 10)
    }
}


