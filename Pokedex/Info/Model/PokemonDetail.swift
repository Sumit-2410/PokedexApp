//
//  PokemonDetail.swift
//  Pokedex
//
//  Created by apple on 12/09/25.
//

import Foundation

struct PokemonDetail: Decodable {
    let id: Int
    let name: String
    let sprites: Sprites
    let stats: [StatEntry]

    struct Sprites: Decodable {
        let front_default: String?
    }
    struct StatEntry: Decodable {
        let base_stat: Int
        let stat: Stat
        
        struct Stat: Decodable {
            let name: String
        }
    }
}
