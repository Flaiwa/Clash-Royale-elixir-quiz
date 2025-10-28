//
//  CR_Card.swift
//  Clash-Royale-elixir-quiz
//
//  Created by Flavio Cheung on 27.10.25.
//

import Foundation

struct CR_Card: Identifiable, Hashable {
    let id: Int
    let name: String
    let imageURL: URL?
    let elixirCost: Int
    let rarity: String?

    init?(api: APICard) {
    
        guard let cost = api.elixirCost else { return nil }
        self.id = api.id
        self.name = api.name
        self.elixirCost = cost
        self.rarity = api.rarity
        self.imageURL = URL(string: api.iconUrls?.medium ?? "")
    }
}
