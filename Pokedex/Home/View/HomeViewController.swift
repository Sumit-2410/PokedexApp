//
//  ViewController.swift
//  Pokedex
//
//  Created by apple on 12/09/25.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pokédex"
        
        setupTableView()
        setupBindings()
        
        viewModel.fetchPokemon()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "PokemonTableViewCell", bundle: nil),
                           forCellReuseIdentifier: "PokemonCell")
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
    
    private func setupBindings() {
        viewModel.onDataUpdated = { [weak self] in
            self?.tableView.reloadData()
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

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredPokemon.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell",
                                                 for: indexPath) as! PokemonTableViewCell
        cell.configure(with: viewModel.filteredPokemon[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        let selectedName = viewModel.filteredPokemon[indexPath.row].name
        let detailVM = PokemonDetailViewModel(name: selectedName)
        let detailVC = InfoViewController(viewModel: detailVM)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filter(with: searchText)
    }
}


