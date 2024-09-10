//
//  Pokemon.swift
//  Pokedex
//
//  Created by Mañanas on 4/9/24.
//

import Foundation
import UIKit


struct Pokemon: Codable {
    let id: Int
    let name: String
    let sprites : Sprites
    let types: [PokemonType]
    let stats: [PokemonStat]
    let abilities: [PokemonAbility]
    let moves: [PokemonMove]
    //let evolutions: [PokemonEvolution]
    //let characteristics: PokemonCharacteristic
}

struct PokemonListResponse: Codable {
        let results: [PokemonEntry]
}

struct PokemonEntry: Codable {
        let name: String
        let url: String
}

struct Sprites: Codable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct PokemonType: Codable {
    let type: TypeName
    
struct TypeName: Codable {
        let name: String
    }
}

struct PokemonStat: Codable {
    let baseStat: Int
    let stat: Stat

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }

struct Stat: Codable {
        let name: String
    }
}

struct PokemonAbility: Codable {
    let ability: Ability

struct Ability: Codable {
        let name: String
    }
}

struct PokemonMove: Codable {
    let move: Move
    
    struct Move: Codable {
        let name: String
    }
}

enum PokemonTypeEnum: String {
    
    case fire, water, grass, electric, psychic, ice, dragon, dark, fairy, fighting, poison, ground, flying, bug, rock, ghost, steel, normal, error
    
    var backgroundColor: UIColor {
        switch self {
        case .fire: return UIColor(hex: "#FF4500")  // OrangeRed
                case .water: return UIColor(hex: "#4169E1")  // RoyalBlue
                case .grass: return UIColor(hex: "#32CD32")  // Lime Green
                case .electric: return UIColor(hex: "#FFD700")  // Gold
                case .psychic: return UIColor(hex: "#FF69B4")  // Hot Pink
                case .ice: return UIColor(hex: "#00CED1")  // Dark Turquoise
                case .dragon: return UIColor(hex: "#8A2BE2")  // Blue Violet
                case .dark: return UIColor(hex: "#4B0082")  // Indigo
                case .fairy: return UIColor(hex: "#FFB6C1")  // Light Pink
                case .fighting: return UIColor(hex: "#8B0000")  // Dark Red
                case .poison: return UIColor(hex: "#8A2BE2")  // Blue Violet
                case .ground: return UIColor(hex: "#DEB887")  // Burly Wood
                case .flying: return UIColor(hex: "#87CEEB")  // Sky Blue
                case .bug: return UIColor(hex: "#9ACD32")  // Yellow Green
                case .rock: return UIColor(hex: "#B8860B")  // Dark Golden Rod
                case .ghost: return UIColor(hex: "#6A5ACD")  // Slate Blue
                case .steel: return UIColor(hex: "#B0C4DE")  // Light Steel Blue
                case .normal: return UIColor(hex: "#A9A9A9")  // Dark Gray
                case .error: return UIColor(hex: "#D3D3D3")  // Light Gray
                }
        }
        
    var borderColor: UIColor {
        switch self {
            case .fire: return UIColor(hex: "#FF6347")  // Tomato
            case .water: return UIColor(hex: "#7B68EE")  // MediumSlateBlue
            case .grass: return UIColor(hex: "#228B22")  // Forest Green
            case .electric: return UIColor(hex: "#FFD700")  // Gold
            case .psychic: return UIColor(hex: "#DB7093")  // Pale Violet Red
            case .ice: return UIColor(hex: "#AFEEEE")  // Pale Turquoise
            case .dragon: return UIColor(hex: "#8A2BE2")  // Blue Violet
            case .dark: return UIColor(hex: "#2F4F4F")  // Dark Slate Gray
            case .fairy: return UIColor(hex: "#FF69B4")  // Hot Pink
            case .fighting: return UIColor(hex: "#8B0000")  // Dark Red
            case .poison: return UIColor(hex: "#BA55D3")  // Medium Orchid
            case .ground: return UIColor(hex: "#D2B48C")  // Tan
            case .flying: return UIColor(hex: "#00BFFF")  // Deep Sky Blue
            case .bug: return UIColor(hex: "#7CFC00")  // Lawn Green
            case .rock: return UIColor(hex: "#8B4513")  // Saddle Brown
            case .ghost: return UIColor(hex: "#483D8B")  // Dark Slate Blue
            case .steel: return UIColor(hex: "#C0C0C0")  // Silver
            case .normal: return UIColor(hex: "#D3D3D3")  // Light Gray
            case .error: return UIColor(hex: "#696969")  // Dim Gray
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

//struct PokemonEvolution : Codable {
    //let name: String
    //let level: Int?
    //let condition: String?
    


//struct PokemonCharacteristic : Codable {
    //let description: String
    //let habitat: String?
    //let shape: String?
    //let color: String?
    

