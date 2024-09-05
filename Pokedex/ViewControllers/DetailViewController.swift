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
    @IBOutlet weak var typeTextView: UILabel!

    
    @IBOutlet weak var statsTextView: UITextView!
    
    @IBOutlet weak var statsStackView: UIStackView!
    
    @IBOutlet weak var abilitiesLabel: UILabel!
    
    @IBOutlet weak var abilitiesTextView: UITextView!
    
    @IBOutlet weak var movesLabel: UILabel!
    
    @IBOutlet weak var movesTextView: UITextView!
    
    
    @IBOutlet weak var typeContainerView: UIView!
    
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
        
        if let firstType = pokemon.types.first?.type.name {
                // Pasa el nombre del tipo a la función de configuración
                configureTypeView(with: firstType)
            } else {
                typeContainerView.isHidden = true
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
    }
    
    private func configureTypeView(with type: String) {
        let typeName = type.lowercased()
        
        // Configura la vista del tipo
        /*typeContainerView.layer.cornerRadius = 10
        typeContainerView.layer.masksToBounds = true
        typeContainerView.backgroundColor = UIColor.lightGray // Ajusta el color según sea necesario*/
        
        let iconImageView = UIImageView()
        let typeLabel = UILabel()
        
        // Configura el ícono
        if let pokemonType = PokemonTypeEnum(rawValue: typeName) {
            iconImageView.image = pokemonType.icon
        } else {
            iconImageView.image = UIImage(named: "default_icon") // Imagen por defecto si el tipo no se encuentra
        }
        
        iconImageView.contentMode = .scaleAspectFit
        
        // Configura el texto
        typeLabel.text = type.capitalized
        typeLabel.textAlignment = .center
        typeLabel.numberOfLines = 0
        
        // Añade las sub-vistas
        /*typeContainerView.addSubview(iconImageView)
        typeContainerView.addSubview(typeLabel)*/
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        /*NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: typeContainerView.topAnchor, constant: 8),
            iconImageView.centerXAnchor.constraint(equalTo: typeContainerView.centerXAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            
            typeLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 8),
            typeLabel.leadingAnchor.constraint(equalTo: typeContainerView.leadingAnchor, constant: 8),
            typeLabel.trailingAnchor.constraint(equalTo: typeContainerView.trailingAnchor, constant: -8),
            typeLabel.bottomAnchor.constraint(equalTo: typeContainerView.bottomAnchor, constant: -8)
        ])*/
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


