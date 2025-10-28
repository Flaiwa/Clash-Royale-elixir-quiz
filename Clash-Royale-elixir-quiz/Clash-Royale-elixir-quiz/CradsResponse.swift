//
//  CradsResponse.swift
//  Clash-Royale-elixir-quiz
//
//  Created by Flavio Cheung on 28.10.25.
//

import Foundation

struct CardsResponse: Decodable {
    let items: [APICard]
}

struct APICard: Decodable, Identifiable {
    let name: String
    let id: Int
    let elixirCost: Int?
    let rarity: String?
    let iconUrls: IconUrls?
}

struct IconUrls: Decodable {
    let medium: String?
    let evolutionMedium: String?
}
