//
//  CircleButtonAnimationView.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 06/03/2025.
//

import SwiftUI

struct CircleButtonAnimationView: View {
    
    @Binding var animate: Bool
//    @State var animate: Bool = false
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
            .scale(animate ? 1.0 : 0.0)
            .opacity(animate ? 0.0 : 1.0)
//            .onAppear {
//                animate.toggle()
//            }
            .animation(animate ? .easeOut(duration: 1.0) : nil, value: animate)
//            .animation(.easeOut(duration: 1.0), value: animate)
    }
}

#Preview {
//    CircleButtonAnimationView()
    CircleButtonAnimationView(animate: .constant(false))
        .frame(width: 100, height: 100)
    
    
}
