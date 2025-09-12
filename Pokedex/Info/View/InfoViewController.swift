//
//  InfoViewController.swift
//  Pokedex
//
//  Created by apple on 12/09/25.
//

import UIKit

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet private weak var pokemonImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!

    private let viewModel: PokemonDetailViewModel
    private var stats: [PokemonDetail.StatEntry] = []

    init(viewModel: PokemonDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "InfoViewController", bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("Use init(viewModel:)") }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        setupBindings()
        viewModel.loadDetail()
    }

    private func setupBindings() {
        viewModel.onDataLoaded = { [weak self] detail in
            self?.nameLabel.text = detail.name.capitalized
            self?.stats = detail.stats
            if let spriteURL = detail.sprites.front_default,
               let url = URL(string: spriteURL) {
                URLSession.shared.dataTask(with: url) { data, _, _ in
                    if let data = data {
                        DispatchQueue.main.async {
                            self?.pokemonImageView.image = UIImage(data: data)
                            self?.tableView.reloadData()
                        }
                    }
                }.resume()
            }
        }

        viewModel.onError = { [weak self] message in
            let alert = UIAlertController(title: "Error",
                                          message: message,
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }
}

extension InfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        stats.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "statCell")
        let stat = stats[indexPath.row]
        cell.textLabel?.text = stat.stat.name.capitalized
        cell.detailTextLabel?.text = "Base: \(stat.base_stat)"
        return cell
    }
}

