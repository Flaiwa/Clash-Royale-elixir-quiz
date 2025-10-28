//
//  QuizViewModel.swift
//  Clash-Royale-elixir-quiz
//
//  Created by Flavio Cheung on 27.10.25.
//
import Foundation
import SwiftUI
import Combine

final class QuizViewModel: ObservableObject {
    @Published var allCards: [CR_Card] = []
    @Published var currentCard: CR_Card?
    @Published var options: [Int] = []
    @Published var score: Int = 0
    @Published var feedback: String? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    private let api = ClashRoyaleAPI()
    private var rng = SystemRandomNumberGenerator()

    func loadCards() {
        isLoading = true
        errorMessage = nil
        api.fetchCards { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            switch result {
            case .success(let apiCards):
                // Map + filtern (nur Karten mit Elixir)
                let mapped = apiCards.compactMap(CR_Card.init(api:))
                // Optional: Duplikate raus (vorsichtshalber per id)
                let unique = Array(Set(mapped))
                self.allCards = unique.sorted { $0.name < $1.name }
                self.nextQuestion()
            case .failure(let err):
                self.errorMessage = err.localizedDescription
            }
        }
    }

    func nextQuestion() {
        feedback = nil
        guard !allCards.isEmpty else { return }
        // Zufällige Karte
        currentCard = allCards.randomElement(using: &rng)
        guard let card = currentCard else { return }

        // Antwortoptionen: 1x korrekt + 2x falsche, aber plausible Elixierwerte
        options = makeOptions(correct: card.elixirCost, in: allCards)
    }

    func checkAnswer(_ value: Int) {
        guard let card = currentCard else { return }
        if value == card.elixirCost {
            score += 1
            feedback = "✅ Richtig!"
        } else {
            feedback = "❌ Falsch! Richtige Antwort: \(card.elixirCost)"
        }
        // Kurze Pause, dann nächste Frage
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            self.nextQuestion()
        }
    }

    // Baut 3 Optionen: korrekt + 2 unterschiedliche andere ElixirKosten, möglichst aus realen Karten
    private func makeOptions(correct: Int, in cards: [CR_Card]) -> [Int] {
        var set = Set<Int>([correct])

        // Kandidaten aus existierenden Karten (realistische Werte)
        var otherCosts = Array(Set(cards.map { $0.elixirCost }))
        otherCosts.removeAll { $0 == correct }

        // Falls zu wenig Varianz existiert, fallback auf Range 1...9
        while set.count < 3 {
            if let pick = otherCosts.randomElement(using: &rng) {
                set.insert(pick)
                otherCosts.removeAll { $0 == pick }
            } else {
                set.insert(Int.random(in: 1...9, using: &rng))
            }
        }
        return Array(set).shuffled()
    }

    func resetScore() {
        score = 0
    }
}
