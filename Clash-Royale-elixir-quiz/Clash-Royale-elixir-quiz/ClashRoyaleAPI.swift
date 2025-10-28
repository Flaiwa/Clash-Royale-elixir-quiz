//
//  ClashRoyaleAPI.swift
//  Clash-Royale-elixir-quiz
//
//  Created by Flavio Cheung on 28.10.25.
//

import Foundation

final class ClashRoyaleAPI {
    // Für den Start okay. Für Produktion: NICHT im App-Binary lassen → über Backend oder sichere Config laden.
    private let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6ImNiNWJhM2ZmLWYyNDItNDdlMi04N2ZkLTZiODNmOGZiYWZlOSIsImlhdCI6MTc2MTYzODQ3Nywic3ViIjoiZGV2ZWxvcGVyLzliNDRjMjA0LWQwMzEtOWZhMi03YjZiLTE5MjQ2MjQ0OTdlYyIsInNjb3BlcyI6WyJyb3lhbGUiXSwibGltaXRzIjpbeyJ0aWVyIjoiZGV2ZWxvcGVyL3NpbHZlciIsInR5cGUiOiJ0aHJvdHRsaW5nIn0seyJjaWRycyI6WyI4Ny4xNjMuMzQuMjI4Il0sInR5cGUiOiJjbGllbnQifV19.q86ZG2lEkPzTZvVxV08PctGft62fToXbkSuwwnN1_Z5zjD7NoGzmtMmF0GE4Kg5DtX90nGgyJY8Vw90ND9FVoQ"

    func fetchCards(completion: @escaping (Result<[APICard], Error>) -> Void) {
        guard let url = URL(string: "https://api.clashroyale.com/v1/cards") else {
            completion(.failure(NSError(domain: "BadURL", code: 0)))
            return
        }

        var request = URLRequest(url: url)
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, resp, err in
            if let err = err {
                DispatchQueue.main.async { completion(.failure(err)) }
                return
            }
            guard let data = data else {
                DispatchQueue.main.async { completion(.failure(NSError(domain: "NoData", code: 0))) }
                return
            }
            do {
                let decoded = try JSONDecoder().decode(CardsResponse.self, from: data)
                DispatchQueue.main.async { completion(.success(decoded.items)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }.resume()
    }
}

