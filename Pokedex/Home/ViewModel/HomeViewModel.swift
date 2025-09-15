//
//  HomeViewModel.swift
//  Pokedex
//
//  Created by apple on 12/09/25.
//

import Foundation

final class HomeViewModel {
    
    private(set) var allPokemon: [PokemonEntry] = []
    private(set) var filteredPokemon: [PokemonEntry] = []
    
    var onDataUpdated: (() -> Void)?
    var onError: ((String) -> Void)?
    
    func fetchPokemon() {
        APIService.shared.request(
            urlString: "https://pokeapi.co/api/v2/pokemon?limit=100"
        ) { (result: Result<PokemonListResponse, Error>) in
            switch result {
            case .success(let response):
                let entries = response.results
                self.allPokemon = entries
                self.filteredPokemon = entries
                self.onDataUpdated?()
            case .failure(let error):
                print("Error:", error)
            }
        }
    }
    
    func filter(with text: String) {
        guard !text.isEmpty else {
            filteredPokemon = allPokemon
            onDataUpdated?()
            return
        }
        filteredPokemon = allPokemon.filter {
            $0.name.lowercased().contains(text.lowercased())
        }
        onDataUpdated?()
    }
}
