//
//  Pokemon.swift
//  Pokedex
//
//  Created by Mañanas on 4/9/24.
//

import Foundation


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

//struct PokemonEvolution : Codable {
    //let name: String
    //let level: Int?
    //let condition: String?
    
}

//struct PokemonCharacteristic : Codable {
    //let description: String
    //let habitat: String?
    //let shape: String?
    //let color: String?
    

