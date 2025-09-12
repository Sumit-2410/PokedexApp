//
//  PokemonService.swift
//  Pokedex
//
//  Created by apple on 12/09/25.
//

import Foundation

protocol PokemonServiceProtocol {
    func fetchPokemonDetail(name: String,
                            completion: @escaping (Result<PokemonDetail, Error>) -> Void)
}

final class PokemonService: PokemonServiceProtocol {
    func fetchPokemonDetail(name: String,
                            completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(name.lowercased())") else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                DispatchQueue.main.async { completion(.failure(error)) }
                return
            }
            guard let data = data else { return }
            do {
                let detail = try JSONDecoder().decode(PokemonDetail.self, from: data)
                DispatchQueue.main.async { completion(.success(detail)) }
            } catch {
                DispatchQueue.main.async { completion(.failure(error)) }
            }
        }.resume()
    }
}
