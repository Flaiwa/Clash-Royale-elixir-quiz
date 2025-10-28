//
//  QuizView.swift
//  Clash-Royale-elixir-quiz
//
//  Created by Ihub Innopot on 28.10.25.
//

import SwiftUI

struct QuizView: View {
    @StateObject private var vm = QuizViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                if vm.isLoading {
                    ProgressView("Loading cards…")
                } else if let error = vm.errorMessage {
                    Text("Error: \(error)").foregroundColor(.red)
                    Button("Retry") { vm.loadCards() }
                        .buttonStyle(.borderedProminent)
                } else if let card = vm.currentCard {
                    Text("Wie viel Elixier kostet diese Karte?")
                        .font(.headline)

                    // Bild von der API laden
                    if let url = card.imageURL {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 180, maxHeight: 220)
                                .shadow(radius: 8)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 180, height: 220)
                        }
                    } else {
                        Rectangle()
                            .fill(.gray.opacity(0.2))
                            .frame(width: 180, height: 220)
                            .overlay(Text(card.name).font(.caption))
                    }

                    Text(card.name)
                        .font(.title3).bold()

                    VStack(spacing: 10) {
                        ForEach(vm.options, id: \.self) { option in
                            Button {
                                vm.checkAnswer(option)
                            } label: {
                                Text("\(option) Elixir")
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue.opacity(0.9))
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                        }
                    }

                    if let fb = vm.feedback {
                        Text(fb)
                            .font(.subheadline)
                            .foregroundColor(fb.contains("Richtig") ? .green : .red)
                            .padding(.top, 4)
                    }

                    Spacer()

                    HStack {
                        Text("Score: \(vm.score)")
                        Spacer()
                        Button("Reset") { vm.resetScore() }
                    }
                    .font(.callout)
                    .padding(.horizontal)
                } else {
                    Text("Keine Karte geladen.")
                    Button("Neu laden") { vm.loadCards() }
                }
            }
            .padding()
            .navigationTitle("CR Elixir Quiz")
            .onAppear { vm.loadCards() }
        }
    }
}
