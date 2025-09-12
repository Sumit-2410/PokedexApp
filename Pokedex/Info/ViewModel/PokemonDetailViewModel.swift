//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by apple on 12/09/25.
//

import Foundation

final class PokemonDetailViewModel {

    private let service: PokemonServiceProtocol
    private let name: String

    // Outputs
    var onDataLoaded: ((PokemonDetail) -> Void)?
    var onError: ((String) -> Void)?

    init(name: String, service: PokemonServiceProtocol = PokemonService()) {
        self.name = name
        self.service = service
    }

    func loadDetail() {
        service.fetchPokemonDetail(name: name) { [weak self] result in
            switch result {
            case .success(let detail):
                self?.onDataLoaded?(detail)
            case .failure(let error):
                self?.onError?(error.localizedDescription)
            }
        }
    }
}
