//
//  ChartView.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 12/03/2025.
//

import SwiftUI

struct ChartView: View {
    
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    
    @State private var percentage: CGFloat = 0
    
    init(coin: Coin) {
        data = coin.sparklineIn7d?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? Color.theme.green : Color.theme.red
        
        endingDate = Date(coinGeckoString: coin.lastUpdated ?? "")
        startingDate = endingDate.addingTimeInterval(-7 * 24 * 60 * 60)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            chart
                .frame(height: 200)
                .background(chartBackground)
                .overlay(chartYAxis.padding(.horizontal, 4), alignment: .leading)
            
            chartDates
                .padding(.horizontal, 4)
        }
        .font(.caption)
        .onAppear {
            withAnimation(.linear(duration: 2.0)) {
                percentage = 1.0
            }
        }
        
    }
}

#Preview {
    ChartView(coin: Coin.previewCoin)
}

extension ChartView {
    private var chart: some View {
        GeometryReader { geometry in
            Path { path in
                
                for i in data.indices {
                    
                    // Example:
                    // 400 points width, 100 items.
                    // Each item has 400 / 100 = 4 points
                    // 5th element has (4 * (4 + 1)) = 20 points xPosition
                    // 31th element has (4 * (30 + 1)) = 124 points xPosition
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(i + 1)
                    
                    // Example
                    // 60,000 - max, 50,000 - min
                    // yAxis: 60,000 - 50,000 = 10,000
                    // If we want 52,000 data point: 52,000 - 50,000 = 2,000
                    // 2,000 / 10,000 = 0.2. It means 20% from the bottom
                    // The axis is in reverse, so we take 100% - 20% = 80%
                    let yAxis = maxY - minY
                    
                    let yPosition = (1 - ((data[i] - minY) / yAxis)) * geometry.size.height
                    
                    if i == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            
            .trim(from: 0, to: percentage)
            .stroke(lineColor, lineWidth: 2)
            .shadow(color:lineColor.opacity(percentage),
                    radius: 10, x: 0, y: 10)
            .shadow(color: lineColor.opacity(0.5),
                    radius: 10, x: 0, y: 15)
            .shadow(color: lineColor.opacity(0.25),
                    radius: 10, x: 0, y: 20)
        }
    }
    
    
    private var chartBackground: some View {
        VStack {
            Divider()
            Spacer()
            Divider()
            Spacer()
            Divider()
        }
    }
    
    private var chartYAxis: some View {
        VStack {
            Text(maxY.formattedWithAbbreviations())
            Spacer()
            Text(((maxY + minY) / 2).formattedWithAbbreviations())
            Spacer()
            Text(minY.formattedWithAbbreviations())
        }
        .foregroundStyle(Color.theme.secondaryText)
    }
    
    private var chartDates: some View {
        HStack {
            Text(startingDate.asShortDateString())
            Spacer()
            Text(endingDate.asShortDateString())
        }
    }
}

