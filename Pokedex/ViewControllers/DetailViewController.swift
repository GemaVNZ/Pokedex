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
    
    @IBOutlet weak var abilitiesTextView: UITextView!
    
    @IBOutlet weak var movesTextView: UITextView!
    
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
        
        //navigationController?.navigationBar.prefersLargeTitles = true
        //navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemGray6]
        
        contentView.roundCorners(radius: 32)

        // Actualiza la UI solo si hay datos de Pokémon disponibles
        if let pokemon = pokemon {
            updateUI(with: pokemon)
        } else {
            // Maneja el caso en el que no haya Pokémon
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
        /*switch sender.selectedSegmentIndex {
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
            }*/
        }
    
    private func showAbout() {
        
    }
    
    private func showStats() {
        
    }
    
    private func showEvolution() {
        
    }
    
    private func showMoves() {
        
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

        
        // Configura las estadísticas del Pokémon con barras de progreso
        
        for i in 0..<pokemon.stats.count {
            let stat = pokemon.stats[i]
            statsLabels[i].text = "\(stat.baseStat)"
            statsProgressViews[i].progress = Float(stat.baseStat) / 255.0
        }
    /*for stat in pokemon.stats {
                    let statsView = UIView()
                    statsView.translatesAutoresizingMaskIntoConstraints = false
                    let label = UILabel()
                    let progressView = UIProgressView(progressViewStyle: .default)
                    
                    label.text = "\(stat.stat.name.capitalized): \(stat.baseStat)"
                    progressView.progress = Float(stat.baseStat) / 255.0 
                    
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
                }*/
        
                // Configura las habilidades del Pokémon
        let abilities = pokemon.abilities.map {$0.ability.name.capitalized }.joined(separator: "\n")
            abilitiesTextView.text = "\(abilities)"
                
                // Configura los movimientos del Pokémon
        let moves = pokemon.moves.map {$0.move.name.capitalized }.joined(separator: "\n")
            movesTextView.text = "\(moves)"
        
        configureTypeView(with: pokemon.types)
    
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
                    typeView.backgroundColor = typeEnum.color
                } else {
                    typeView.backgroundColor = .gray
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


