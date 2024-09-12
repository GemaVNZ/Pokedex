//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Mañanas on 5/9/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    @IBOutlet weak var typeStackView: UIStackView!
    
    //@IBOutlet weak var characteristicsTextView: UITextView!
    
    @IBOutlet weak var evolution1TextView: UITextView!
    
    @IBOutlet weak var evolution2TextView: UITextView!
    
    @IBOutlet weak var evolution1ImageView: UIImageView!
    
    @IBOutlet weak var evolution2ImageView: UIImageView!
    
    @IBOutlet weak var movesTextView: UITextView!
    
    @IBOutlet weak var backgroundView: UIView!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var typeView: UIView!
    
    @IBOutlet weak var contentSegmentedControl: UISegmentedControl!
    
    @IBOutlet var tabContentViews: [UIView]!
    
    @IBOutlet var statsProgressViews: [UIProgressView]!
    
    @IBOutlet var statsLabels: [UILabel]!
    
    var selectedTab: Int = 0
    
    var pokemon : Pokemon?

    let pokemonProvider = PokemonProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.roundCorners(radius: 32)

            if let pokemon = pokemon {
                updateUI(with: pokemon)
            } else {
                showError(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No se pudo cargar el Pokémon."]))
            }
            
            for tab in tabContentViews {
                tab.isHidden = true
            }
            
            tabContentViews[selectedTab].isHidden = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    @IBAction func contentSegmenAction(_ sender: UISegmentedControl) {
        tabContentViews[selectedTab].isHidden = true
        selectedTab = sender.selectedSegmentIndex
        tabContentViews[selectedTab].isHidden = false
        
        switch sender.selectedSegmentIndex {
            case 0:
                showAbout()
            case 1:
                showStats()
            case 2:
                showEvolution()
            case 3:
                showMoves()
            default:
                break
            }
        }
    
    private func showAbout() {
        /*guard let pokemon = pokemon else { return }
        pokemonProvider.loadCharacteristics(for: pokemon.id) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let characteristics):
                    self?.updateCharacteristicsUI(with: characteristics)
                case .failure(let error):
                    print("Error al cargar las características: \(error.localizedDescription)")
                }
            }
        }*/
    }
    
    private func showStats() {
        guard let pokemon = pokemon else { return }
            DispatchQueue.main.async {
                for i in 0..<pokemon.stats.count {
                    let stat = pokemon.stats[i]
                    self.statsLabels[i].text = "\(stat.baseStat)"
                    self.statsProgressViews[i].progress = Float(stat.baseStat) / 255.0
                }
            }
        }
    private func showEvolution() {
        guard let pokemon = pokemon else { return }
            
            // Usa la URL de la especie para obtener la cadena de evolución
            let speciesUrl = pokemon.species.url
            
            pokemonProvider.loadPokemonSpecies(from: speciesUrl) { [weak self] result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let species):
                        // Ahora que tenemos la especie, obtenemos la cadena de evolución
                        self?.pokemonProvider.loadEvolutionChain(from: species.evolutionChain.url) { evolutionResult in
                            switch evolutionResult {
                            case .success(let evolutions):
                                self?.updateEvolutionsUI(with: evolutions)
                            case .failure(let error):
                                print("Error al cargar la cadena de evolución: \(error.localizedDescription)")
                            }
                        }
                    case .failure(let error):
                        print("Error al cargar la especie: \(error.localizedDescription)")
                    }
                }
            }
        }
    
    private func showMoves() {
        guard let pokemon = pokemon else { return }
                let moves = pokemon.moves.map { $0.move.name.capitalized }.joined(separator: "\n")
                movesTextView.text = moves
    }
    

    private func updateUI(with pokemon: Pokemon) {
        self.navigationItem.title = pokemon.name.capitalized
            
            // Configura la imagen del Pokémon
            if let imageUrlString = pokemon.sprites.frontDefault, let imageUrl = URL(string: imageUrlString) {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: imageUrl), let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.pokemonImageView.image = image
                        }
                    }
                }
            }
            
    if let primaryType = pokemon.types.first?.type.name.lowercased(),
            let typeEnum = PokemonTypeEnum(rawValue: primaryType) {
            self.backgroundView.backgroundColor = typeEnum.pastelColor
            } else {
            self.contentView.backgroundColor = .white
            }

        
        // Configura las estadísticas del Pokémon con barras de progreso
        for i in 0..<pokemon.stats.count {
            let stat = pokemon.stats[i]
            statsLabels[i].text = "\(stat.baseStat)"
            statsProgressViews[i].progress = Float(stat.baseStat) / 255.0
        }
        // Configura las habilidades del Pokémon
        //let abilities = pokemon.abilities.map {$0.ability.name.capitalized }.joined(separator: "\n")
            //characteristicsTextView.text = "\(abilities)"
                
        // Configura los movimientos del Pokémon
        let moves = pokemon.moves.map {$0.move.name.capitalized }.joined(separator: "\n")
            movesTextView.text = "\(moves)"
        
        configureTypeView(with: pokemon.types)
        
        showEvolution()
    
    }
    
    private func configureTypeView(with types: [PokemonType]) {
        
        typeStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for pokemonType in types {
                let typeName = pokemonType.type.name.lowercased()

                // Crea una vista para el tipo
                let typeView = UIView()
                typeView.translatesAutoresizingMaskIntoConstraints = false
                typeView.layer.cornerRadius = 8
                typeView.clipsToBounds = true

                //Se añade el color dependiendo del tipo de pokemon
                if let typeEnum = PokemonTypeEnum(rawValue: typeName) {
                    typeView.backgroundColor = typeEnum.backgroundColor
                    typeView.layer.borderColor = typeEnum.borderColor.cgColor
                    typeView.layer.borderWidth = 2.0
                } else {
                    typeView.backgroundColor = .gray
                    typeView.layer.borderColor = UIColor.darkGray.cgColor
                    typeView.layer.borderWidth = 2.0
                }

                // Se crea una etiqueta para diseñar el formato de los tipos
                let typeLabel = UILabel()
                typeLabel.translatesAutoresizingMaskIntoConstraints = false
                typeLabel.text = pokemonType.type.name.capitalized
                typeLabel.textAlignment = .center
                typeLabel.textColor = .white
                typeLabel.font = UIFont.boldSystemFont(ofSize: 14)

                // Se agrega la etiqueta a la vista de tipo
                typeView.addSubview(typeLabel)

                // Se establece las restricciones de la etiqueta
                NSLayoutConstraint.activate([
                    typeLabel.centerXAnchor.constraint(equalTo: typeView.centerXAnchor),
                    typeLabel.centerYAnchor.constraint(equalTo: typeView.centerYAnchor),
                    typeLabel.leadingAnchor.constraint(equalTo: typeView.leadingAnchor, constant: 8),
                    typeLabel.trailingAnchor.constraint(equalTo: typeView.trailingAnchor, constant: -8)
                ])

                // Establece las restricciones para la vista de tipo
                NSLayoutConstraint.activate([
                    typeView.widthAnchor.constraint(equalToConstant: 80),
                    typeView.heightAnchor.constraint(equalToConstant: 40)
                ])

                // Se agrega la vista de tipo al stack view
                typeStackView.addArrangedSubview(typeView)
            }
    }

    private func fetchEvolutionImages(for evolutions: [PokemonEvolution], completion: @escaping ([UIImage?]) -> Void) {
        let group = DispatchGroup()
        var images: [UIImage?] = Array(repeating: nil, count: evolutions.count)

        for (index, evolution) in evolutions.enumerated() {
            group.enter()
            // Realiza la búsqueda del Pokémon usando su nombre
            let pokemonUrl = "https://pokeapi.co/api/v2/pokemon/\(evolution.name.lowercased())"
            pokemonProvider.loadPokemonDetails(from: pokemonUrl) { result in
                switch result {
                case .success(let pokemon):
                    if let imageUrlString = pokemon.sprites.frontDefault, let imageUrl = URL(string: imageUrlString) {
                        self.loadImage(from: imageUrl) { image in
                            images[index] = image
                            group.leave()
                        }
                    } else {
                        group.leave()
                    }
                case .failure:
                    group.leave()
                }
            }
        }

        group.notify(queue: .main) {
            completion(images)
        }
    }

    private func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                completion(nil)
            }
        }
    }
    
    
    private func updateEvolutionsUI(with evolutions: [PokemonEvolution]) {
        fetchEvolutionImages(for: evolutions) { images in
            guard evolutions.count > 0 else {
                self.evolution1TextView.text = "No evolutions available"
                self.evolution2TextView.isHidden = true
                self.evolution1ImageView.isHidden = true
                return
            }

            // Actualizar UI con la primera evolución
            let firstEvolution = evolutions[0]
            var evolutionText = "- \(firstEvolution.name)"
            if let level = firstEvolution.level {
                evolutionText += " at level \(level)"
            }
            self.evolution1TextView.text = evolutionText
            self.evolution1ImageView.image = images[0]
            self.evolution1ImageView.isHidden = images[0] == nil

            if evolutions.count > 1 {
                let secondEvolution = evolutions[1]
                var secondEvolutionText = "- \(secondEvolution.name)"
                if let level = secondEvolution.level {
                    secondEvolutionText += " at level \(level)"
                }
                if let condition = secondEvolution.condition, !condition.isEmpty {
                    secondEvolutionText += " (Condition: \(condition))"
                }
                self.evolution2TextView.text = secondEvolutionText
                self.evolution2ImageView.image = images[1]
                self.evolution2ImageView.isHidden = images[1] == nil
            } else {
                self.evolution2TextView.text = ""
                self.evolution2ImageView.isHidden = true
            }
        }
    }
    
    private func showError(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


