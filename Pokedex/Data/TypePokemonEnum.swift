//
//  TypePokemonEnum.swift
//  Pokedex
//
//  Created by Mañanas on 11/9/24.
//

import Foundation
import UIKit

enum PokemonTypeEnum: String {
    
    case fire, water, grass, electric, psychic, ice, dragon, dark, fairy, fighting, poison, ground, flying, bug, rock, ghost, steel, normal, error
    
    var backgroundColor: UIColor {
            switch self {
                case .fire: return UIColor(hex: "#F08030")  // Fire
                case .water: return UIColor(hex: "#6890F0")  // Water
                case .grass: return UIColor(hex: "#78C850")  // Grass
                case .electric: return UIColor(hex: "#F8D030")  // Electric
                case .psychic: return UIColor(hex: "#F85888")  // Psychic
                case .ice: return UIColor(hex: "#98D8D8")  // Ice
                case .dragon: return UIColor(hex: "#7038F8")  // Dragon
                case .dark: return UIColor(hex: "#705848")  // Dark
                case .fairy: return UIColor(hex: "#EE99AC")  // Fairy
                case .fighting: return UIColor(hex: "#C03028")  // Fighting
                case .poison: return UIColor(hex: "#A040A0")  // Poison
                case .ground: return UIColor(hex: "#E0C068")  // Ground
                case .flying: return UIColor(hex: "#A890F0")  // Flying
                case .bug: return UIColor(hex: "#A8B820")  // Bug
                case .rock: return UIColor(hex: "#B8A038")  // Rock
                case .ghost: return UIColor(hex: "#705898")  // Ghost
                case .steel: return UIColor(hex: "#B8B8D0")  // Steel
                case .normal: return UIColor(hex: "#A8A878")  // Normal
                case .error: return UIColor(hex: "#D3D3D3")  // Light Gray (Error)
            }
        }
        
        var borderColor: UIColor {
            switch self {
                case .fire: return UIColor(hex: "#E24242")  // Fire (Border)
                case .water: return UIColor(hex: "#539DDF")  // Water (Border)
                case .grass: return UIColor(hex: "#4EC05B")  // Grass (Border)
                case .electric: return UIColor(hex: "#F3D23B")  // Electric (Border)
                case .psychic: return UIColor(hex: "#F85888")  // Psychic (Border)
                case .ice: return UIColor(hex: "#87CEEB")  // Ice (Border)
                case .dragon: return UIColor(hex: "#7038F8")  // Dragon (Border)
                case .dark: return UIColor(hex: "#5A5366")  // Dark (Border)
                case .fairy: return UIColor(hex: "#D685AD")  // Fairy (Border)
                case .fighting: return UIColor(hex: "#D04164")  // Fighting (Border)
                case .poison: return UIColor(hex: "#A040A0")  // Poison (Border)
                case .ground: return UIColor(hex: "#E0C068")  // Ground (Border)
                case .flying: return UIColor(hex: "#A890F0")  // Flying (Border)
                case .bug: return UIColor(hex: "#A8B820")  // Bug (Border)
                case .rock: return UIColor(hex: "#B8A038")  // Rock (Border)
                case .ghost: return UIColor(hex: "#705898")  // Ghost (Border)
                case .steel: return UIColor(hex: "#B8B8D0")  // Steel (Border)
                case .normal: return UIColor(hex: "#A8A878")  // Normal (Border)
                case .error: return UIColor(hex: "#696969")  // Dim Gray (Error)
            }
        }
                
    var pastelColor: UIColor {
        switch self {
            case .fire: return UIColor(hex: "#FFD1C1")  // Light Coral
            case .water: return UIColor(hex: "#ADD8E6")  // Light Blue
            case .grass: return UIColor(hex: "#C1E1C1")  // Light Green
            case .electric: return UIColor(hex: "#FFECB3")  // Light Yellow
            case .psychic: return UIColor(hex: "#FFCCE5")  // Light Pink
            case .ice: return UIColor(hex: "#E0FFFF")  // Light Cyan
            case .dragon: return UIColor(hex: "#E6E6FA")  // Lavender
            case .dark: return UIColor(hex: "#D3D3D3")  // Light Gray
            case .fairy: return UIColor(hex: "#FFB6C1")  // Light Pink
            case .fighting: return UIColor(hex: "#FAEBD7")  // Antique White
            case .poison: return UIColor(hex: "#E6E6FA")  // Lavender
            case .ground: return UIColor(hex: "#FFFACD")  // Lemon Chiffon
            case .flying: return UIColor(hex: "#F0F8FF")  // Alice Blue
            case .bug: return UIColor(hex: "#F5FFFA")  // Mint Cream
            case .rock: return UIColor(hex: "#FAFAD2")  // Light Goldenrod Yellow
            case .ghost: return UIColor(hex: "#DCDCDC")  // Gainsboro
            case .steel: return UIColor(hex: "#F5F5F5")  // White Smoke
            case .normal: return UIColor(hex: "#F0F0F0")  // Light Gray
            case .error: return UIColor(hex: "#F5F5F5")  // White Smoke
                    }
                }
            }
