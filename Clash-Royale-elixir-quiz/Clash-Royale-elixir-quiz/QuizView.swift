//
//  QuizView.swift
//  Clash-Royale-elixir-quiz
//
//  Created by Flavio Cheung on 28.10.25.
//
import SwiftUI

struct QuizView: View {
    @StateObject private var vm = QuizViewModel()

    var body: some View {
        ZStack {
            // Hintergrund GANZ HINTEN
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.05, green: 0.28, blue: 0.63),
                    Color.purple
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            // Inhalt DARÜBER
            VStack(spacing: 20) {
                Text("CR Elixir Quiz")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                Text("Wie viel Elixier kostet diese Karte?")
                    .foregroundColor(.white)

                if let card = vm.currentCard {
                    AsyncImage(url: card.imageURL) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 260)
                            .shadow(radius: 8)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 200, height: 260)
                    }

                    Text(card.name)
                        .font(.title3)
                        .foregroundColor(.white)

                    // Elixier-Bubbles
                    VStack(spacing: 30) {
                        ForEach(vm.options, id: \.self) { option in
                            ElixirButton(value: option) {
                                vm.checkAnswer(option)
                            }
                        }
                    }
                }

                Spacer()

                HStack {
                    Text("Score: \(vm.score)")
                        .foregroundColor(.white)
                    Spacer()
                    Button("Reset") { vm.resetScore() }
                        .foregroundColor(.white)
                }
            }
            .padding()
        }
        .onAppear {
            vm.loadCards()   // 👈 ganz wichtig: Karten laden
        }
    }
}
