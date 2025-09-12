//
//  Pokemon.swift
//  Pokedex
//
//  Created by apple on 12/09/25.
//

import Foundation


struct PokemonListResponse: Decodable {
    let results: [PokemonEntry]
}

struct PokemonEntry: Decodable {
    let name: String
    let url: String
    
    var imageURL: URL {
        let id = url.split(separator: "/").last { !$0.isEmpty } ?? "1"
        return URL(string:
           "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png"
        )!
    }
}
