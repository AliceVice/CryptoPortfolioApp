//
//  SearchBarView.swift
//  CryptoApp
//
//  Created by Andrei Isayenka on 08/03/2025.
//

import SwiftUI

struct SearchBarView: View {
    
    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(
                    searchText.isEmpty ? Color.theme.secondaryText : Color.theme.accent
                )
            
            TextField("Search by name of symbol...", text: $searchText)
                .foregroundStyle(Color.theme.accent)
                .autocorrectionDisabled()
                .overlay(
                    Image(systemName: "xmark.circle.fill")
                        .opacity(searchText.isEmpty ? 0 : 0.8)
                        .foregroundStyle(Color.theme.accent)
                        .overlay(
                            // Increase area of button's tap gesture
                            Color.clear
                                .frame(width: 40, height: 40)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    UIApplication.shared.endEditing()
                                    searchText = ""
                                }
                        )
                    , alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.background)
                .shadow(color: Color.theme.accent.opacity(0.5), radius: 10, x: 0, y: 0)
        )
        .padding()
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    SearchBarView(searchText: .constant(""))
        .preferredColorScheme(.dark)
}

#Preview(traits: .sizeThatFitsLayout) {
    SearchBarView(searchText: .constant(""))
        .preferredColorScheme(.light)
}
