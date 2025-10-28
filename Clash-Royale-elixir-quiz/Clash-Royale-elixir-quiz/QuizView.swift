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
            // Background
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.05, green: 0.28, blue: 0.63),
                    Color.purple
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            //Titel + description + Card + Elixir Buttons
            VStack(spacing: 20) {
                Text("Clash Royale Quiz")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)

                Text("How much elixir cost this Card")
                    .foregroundColor(.white)
                    .bold()

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
                // for the feedback
                if let fb = vm.feedback {
                    Text(fb)
                        .font(.headline)
                        .foregroundColor(fb.contains("Correct") ? .green : .red)
                        .shadow(color: .black, radius: 2, x: 1, y: 1)
                        .padding(.top)
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
            vm.loadCards()   
        }
    }
}
