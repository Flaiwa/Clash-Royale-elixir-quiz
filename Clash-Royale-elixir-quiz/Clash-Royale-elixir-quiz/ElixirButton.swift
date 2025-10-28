//
//  ElixirButton.swift
//  Clash-Royale-elixir-quiz
//
//  Created by Flavio Cheung on 28.10.25.
//

import SwiftUI

struct ElixirButton: View {
    let value: Int
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            ZStack {
                Image("elixir 1")   // dein Asset-Name
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80) // Größe anpassen
                
                Text("\(value)")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(color: .black, radius: 2, x: 1, y: 1) // für besseren Kontrast
            }
        }
        .buttonStyle(.plain) // verhindert den Standard-Button-Style
    }
}

