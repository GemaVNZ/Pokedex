//
//  TableViewCell.swift
//  Pokedex
//
//  Created by Mañanas on 4/9/24.
//

import UIKit

class PokemonViewCell: UITableViewCell {
    
    
    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var pokemonIDLabel: UILabel!
    
    @IBOutlet weak var typeColorView: UIView!
    
    @IBOutlet weak var pokemonIconImageView: UIImageView!
    
    @IBOutlet weak var pokemontypeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func render(pokemon : Pokemon) {
        pokemonImage.image = nil
    
        nameLabel.text = pokemon.name.capitalized
        pokemonIDLabel.text = "#\(pokemon.id)"
               
        // Configurar la imagen del Pokémon
        pokemonImage.image = UIImage(named: "image-placeholder")
               if let imageUrlString = pokemon.sprites.frontDefault, let imageUrl = URL(string: imageUrlString) {
                   
                   let task = URLSession.shared.dataTask(with: imageUrl) { [weak self] data, response, error in
                      
                       if let error = error {
                           print("Error al cargar la imagen: \(error.localizedDescription)")
                           DispatchQueue.main.async {
                               self?.pokemonImage.image = UIImage(named: "image-placeholder")
                           }
                           return
                       }
                       
                       guard let data = data, let image = UIImage(data: data) else {
                           DispatchQueue.main.async {
                               self?.pokemonImage.image = UIImage(named: "image-placeholder")
                           }
                           return
                       }
                       
                       DispatchQueue.main.async {
                           self?.pokemonImage.image = image
                       }
                   }
                   task.resume()
               } else {
                   pokemonImage.image = UIImage(named: "image-placeholder")
               }
               
               if let primaryType = pokemon.types.first?.type {
                   pokemontypeLabel.text = primaryType.name.capitalized
                   pokemonIconImageView.image = UIImage(named: primaryType.name)
            
                   pokemonIconImageView.tintColor = UIColor(named: primaryType.name)
                   
               } else {
                   pokemontypeLabel.text = "Unknown"
                   pokemonIconImageView.image = nil
                   pokemonIconImageView.tintColor = .clear
               }
           }
       }
