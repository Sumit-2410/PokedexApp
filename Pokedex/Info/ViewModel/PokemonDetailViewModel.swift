//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by apple on 12/09/25.
//

import Foundation

final class PokemonDetailViewModel {

    private let name: String

    // Outputs
    var onDataLoaded: ((PokemonDetail) -> Void)?
    var onError: ((String) -> Void)?

    init(name: String) {
        self.name = name
    }

    func loadDetail() {
        APIService.shared.request(
            urlString: "https://pokeapi.co/api/v2/pokemon/\(name.lowercased())"
        ) { (result: Result<PokemonDetail, Error>) in
            switch result {
            case .success(let detail):
                self.onDataLoaded?(detail)
            case .failure(let error):
                print("Error:", error)
            }
        }
    }
}
