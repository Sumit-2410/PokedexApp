//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by apple on 12/09/25.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(with pokemon: PokemonEntry) {
        nameLabel.text = pokemon.name.capitalized
        loadImage(from: pokemon.imageURL)
    }
    
    private func loadImage(from url: URL) {
        pokemonImageView.image = nil
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.pokemonImageView.image = image
                }
            }
        }.resume()
    }
}

