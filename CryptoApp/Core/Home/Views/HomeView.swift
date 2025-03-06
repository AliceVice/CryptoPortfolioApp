//
//  HomeView.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 06/03/2025.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio: Bool = false
    
    var body: some View {
        ZStack {
            
            // background layer
            Color.theme.background
                .ignoresSafeArea()
            
            // content layer
            VStack {
                navigationView
                
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
}

