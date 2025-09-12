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
        APIService.shared.fetchPokemonList { [weak self] result in
            switch result {
            case .success(let list):
                self?.allPokemon = list
                self?.filteredPokemon = list
                self?.onDataUpdated?()
            case .failure(let error):
                self?.onError?(error.localizedDescription)
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
