//
//  XMarkButton.swift
//  CryptoTracker
//
//  Created by Halisson da Silva Jesus on 10/06/24.
//

import SwiftUI

struct XMarkButton: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button(action: {
            dismiss()
        }, label: {
            Image(systemName: "xmark")
                .font(.headline)
                .foregroundColor(Color.theme.accent)
        })
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    XMarkButton()
}
