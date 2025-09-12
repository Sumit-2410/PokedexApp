//
//  APIService.swift
//  Pokedex
//
//  Created by apple on 12/09/25.
//

import Foundation

final class APIService {
    static let shared = APIService()
    
    func fetchPokemonList(completion: @escaping (Result<[PokemonEntry], Error>) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=100"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }
            guard let data = data else { return }
            do {
                let response = try JSONDecoder().decode(PokemonListResponse.self, from: data)
                DispatchQueue.main.async { completion(.success(response.results)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }.resume()
    }
}

