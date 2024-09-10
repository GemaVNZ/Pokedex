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
        
        var color: UIColor {
            switch self {
            case .fire: return .red
            case .water: return .blue
            case .grass: return .green
            case .electric: return .yellow
            case .psychic: return .purple
            case .ice: return UIColor.systemGray
            case .dragon: return UIColor.systemYellow
            case .dark: return UIColor.systemYellow
            case .fairy: return UIColor.systemYellow
            case .fighting: return UIColor.systemYellow
            case .poison: return UIColor.systemPurple
            case .ground: return UIColor.systemYellow
            case .flying: return UIColor.systemYellow
            case .bug: return UIColor.systemYellow
            case .rock: return UIColor.systemYellow
            case .ghost: return UIColor.systemYellow
            case .steel: return UIColor.systemYellow
            case .normal: return UIColor.systemYellow
            case .error : return UIColor.lightGray
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
    

