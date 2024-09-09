//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Mañanas on 5/9/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    
    @IBOutlet weak var typeImageView: UIImageView!

    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var statsStackView: UIStackView!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBOutlet weak var abilitiesTextView: UITextView!
    
    @IBOutlet weak var movesLabel: UILabel!
    
    @IBOutlet weak var movesTextView: UITextView!
    
    
    var pokemon : Pokemon?
    
    let pokemonProvider = PokemonProvider()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Actualiza la UI solo si hay datos de Pokémon disponibles
        if let pokemon = pokemon {
            updateUI(with: pokemon)
        } else {
            // Maneja el caso en el que no haya Pokémon
            showError(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No se pudo cargar el Pokémon."]))
        }
    }
    
    private func updateUI(with pokemon: Pokemon) {
        self.navigationItem.title = pokemon.name
        
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
        
        
        // Configura las estadísticas del Pokémon con barras de progreso
        for stat in pokemon.stats {
                    let statsView = UIView()
                    statsView.translatesAutoresizingMaskIntoConstraints = false
                    let label = UILabel()
                    let progressView = UIProgressView(progressViewStyle: .default)
                    
                    label.text = "\(stat.stat.name.capitalized): \(stat.baseStat)"
                    progressView.progress = Float(stat.baseStat) / 255.0  // Suponiendo que el máximo es 255
                    
                    statsView.addSubview(label)
                    statsView.addSubview(progressView)
                    
                    label.translatesAutoresizingMaskIntoConstraints = false
                    progressView.translatesAutoresizingMaskIntoConstraints = false
                    
                    NSLayoutConstraint.activate([
                        label.leadingAnchor.constraint(equalTo: statsView.leadingAnchor),
                        label.topAnchor.constraint(equalTo: statsView.topAnchor),
                        label.trailingAnchor.constraint(equalTo: progressView.leadingAnchor, constant: -8),
                        progressView.centerYAnchor.constraint(equalTo: label.centerYAnchor),
                        progressView.trailingAnchor.constraint(equalTo: statsView.trailingAnchor),
                        progressView.widthAnchor.constraint(equalToConstant: 150),
                        progressView.heightAnchor.constraint(equalToConstant: 10)
                    ])
                    
                    statsStackView.addArrangedSubview(statsView)
                }
        
                // Configura las habilidades del Pokémon
        let abilities = pokemon.abilities.map {$0.ability.name.capitalized }.joined(separator: "\n")
            abilitiesTextView.text = "\(abilities)"
                
                // Configura los movimientos del Pokémon
        let moves = pokemon.moves.map {$0.move.name.capitalized }.joined(separator: "\n")
            movesTextView.text = "\(moves)"
        
        if let firstType = pokemon.types.first?.type.name {
                configureTypeView(with: firstType)
            }
    }
    
    private func configureTypeView(with type: String) {
        let typeName = type.lowercased()
        
        // Configura el ícono de tipo usando typeImageView
        if let pokemonType = PokemonTypeEnum(rawValue: typeName) {
            typeImageView.image = pokemonType.icon
        } else {
            typeImageView.image = UIImage(named: "default_icon") 
        }
        
        typeImageView.contentMode = .scaleAspectFit
        // Configura el texto de tipo usando typeLabel
        typeLabel.text = type.capitalized
        typeLabel.textAlignment = .center
        typeLabel.numberOfLines = 0
        
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


