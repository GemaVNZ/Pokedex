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
    
    var icon: UIImage? {
        switch self {
        case .fire: return UIImage(named: "fire_icon")
        case .water: return UIImage(named: "water_icon")
        case .grass:return UIImage(named: "fire_icon")
        case .electric:return UIImage(named: "fire_icon")
        case .psychic:return UIImage(named: "fire_icon")
        case .ice:return UIImage(named: "fire_icon")
        case .dragon:return UIImage(named: "fire_icon")
        case .dark:return UIImage(named: "fire_icon")
        case .fairy:return UIImage(named: "fire_icon")
        case .fighting:return UIImage(named: "fire_icon")
        case .poison:return UIImage(named: "fire_icon")
        case .ground:return UIImage(named: "fire_icon")
        case .flying:return UIImage(named: "fire_icon")
        case .bug:return UIImage(named: "fire_icon")
        case .rock:return UIImage(named: "fire_icon")
        case .ghost:return UIImage(named: "fire_icon")
        case .steel:return UIImage(named: "fire_icon")
        case .normal:return UIImage(named: "fire_icon")
        case .error:return UIImage(named:"defaul_icon")
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
    

