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
    let height: Int
    let weight: Int
    let species: Species
    let sprites: Sprites
    let types: [PokemonType]
    let stats: [PokemonStat]
    let abilities: [PokemonAbility]
    let moves: [PokemonMove]
    var evolutions: [PokemonEvolution]?
    var speciesData: PokemonSpecies?
    var damageRelations: DamageRelations?
    
    var gender: String {
        if let genderRate = species.genderRate {
            switch genderRate {
            case -1:
                return "Sin género"
            case 0:
                return "100% Macho"
            case 8:
                return "100% Hembra"
            default:
                // Convertimos 'genderRate' a Double para realizar operaciones con decimales
                let malePercentage = (8.0 - Double(genderRate)) * 12.5
                let femalePercentage = 100 - malePercentage
                return "Macho: \(malePercentage)% - Hembra: \(femalePercentage)%"
            }
        }
        return "Desconocido"
    }
}

struct PokemonListResponse: Codable {
    let results: [PokemonEntry]
}

struct PokemonEntry: Codable {
    let name: String
    let url: String
}

struct Species: Codable {
    let name: String
    let url: String
    let genderRate: Int?
}

struct Sprites: Codable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct PokemonType: Codable {
    let type: TypeDetail

    struct TypeDetail: Codable {
        let name: String
        let url: String
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
        let url: String
    }
}

struct PokemonMove: Codable {
    let move: Move

    struct Move: Codable {
        let name: String
    }
}

struct PokemonEvolution: Codable {
    let name: String
    let imageURL: URL?
    let level: Int?
    let condition: String?
}

struct PokemonSpecies: Codable {
    let habitat: Habitat?
    let genderRate: Int?
    let evolutionChain: EvolutionChainReference

    enum CodingKeys: String, CodingKey {
        case habitat
        case genderRate = "gender_rate"
        case evolutionChain = "evolution_chain"
    }
}

struct Habitat: Codable {
    let name: String
}

struct EvolutionChainReference: Codable {
    let url: String
}

struct EvolutionChainResponse: Codable {
    let chain: EvolutionChain
}

struct EvolutionChain: Codable {
    let species: Species
    let evolvesTo: [EvolutionChain]
    
    enum CodingKeys: String, CodingKey {
        case species
        case evolvesTo = "evolves_to"
    }
}

// Nueva estructura TypeName para corregir el error 'Cannot find type 'TypeName' in scope'
struct TypeName: Codable {
    let name: String
}

struct DamageRelationsResponse: Codable {
    let damageRelations: DamageRelations
    
    enum CodingKeys: String, CodingKey {
        case damageRelations = "damage_relations"
    }
}

struct DamageRelations: Codable {
    let noDamageTo: [TypeName]
    let halfDamageTo: [TypeName]
    let doubleDamageTo: [TypeName]
    let noDamageFrom: [TypeName]
    let halfDamageFrom: [TypeName]
    let doubleDamageFrom: [TypeName]

    enum CodingKeys: String, CodingKey {
        case noDamageTo = "no_damage_to"
        case halfDamageTo = "half_damage_to"
        case doubleDamageTo = "double_damage_to"
        case noDamageFrom = "no_damage_from"
        case halfDamageFrom = "half_damage_from"
        case doubleDamageFrom = "double_damage_from"
    }
}
