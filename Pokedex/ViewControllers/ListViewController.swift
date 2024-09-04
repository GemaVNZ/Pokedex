//
//  ViewController.swift
//  Pokedex
//
//  Created by Mañanas on 4/9/24.
//

import UIKit

class ListViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemonList: [Pokemon] = []
    
    let pokemonProvider = PokemonProvider()
    
    var isLoading = false
    
    private var searchTimer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        searchBar.delegate = self
        
        self.navigationItem.title = "Pokedex"
        
        loadInitialPokemons()
        
        
    }
    
    private func loadInitialPokemons() {
            searchPokemon(name: "pikachu") 
        }
    
    //Actualizar los datos de la vista
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // Funciones asociadas al TableView para pintar la vista de la celda
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PokemonViewCell
        let pokemon = pokemonList[indexPath.row]
        cell.render(pokemon: pokemon)
        return cell
    }
    
    private func setupSearchBar() {
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
            searchTextField.autocapitalizationType = .none
        }
    }
    
    // Realiza la búsqueda cuando se presiona el botón de búsqueda
    internal func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()  // Oculta el teclado
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        searchPokemon(name: searchText.lowercased())
    }
    
    // Maneja el texto de búsqueda con debounce
    internal func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchTimer?.invalidate()
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            
            // En lugar de buscar automáticamente con cada cambio de texto, limpia la lista si el texto está vacío
            if searchText.isEmpty {
                self.pokemonList = []
                self.tableView.reloadData()
            }
        }
    }
    
    internal func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        pokemonList = []
        tableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    private func searchPokemon(name: String) {
        guard !isLoading else { return }
        
        isLoading = true
        pokemonProvider.searchPokemonbyName(name) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                switch result {
                case .success(let pokemon):
                    self.pokemonList = [pokemon]
                    self.tableView.reloadData()
                    print("Pokémon encontrado: \(pokemon.name)")
                    
                case .failure(let error):
                    self.pokemonList = []
                    self.tableView.reloadData()
                    print("Error al buscar Pokémon: \(error.localizedDescription)")
                    
                    let alert = UIAlertController(title: "Error", message: "No se pudo encontrar el Pokémon.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
}
    
    
