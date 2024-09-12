//
//  PokemonProvider.swift
//  Pokedex
//
//  Created by Mañanas on 4/9/24.
//

import Foundation
import UIKit

class PokemonProvider {
    
    private let networkManager = NetworkManager()
    private let batchSize = 1000  // Tamaño del lote, ajusta según sea necesario
    
    func loadAllPokemons(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        var allPokemons: [Pokemon] = []
        var currentOffset = 0
        
        func loadNextBatch() {
            let urlString = "https://pokeapi.co/api/v2/pokemon?limit=\(batchSize)&offset=\(currentOffset)"
            
            networkManager.loadData(from: urlString, decodeType: PokemonListResponse.self) { result in
                switch result {
                case .success(let response):
                    print("Pokémon List Response: \(response)") // Imprime la respuesta para verificar
                    let dispatchGroup = DispatchGroup()
                    
                    for entry in response.results {
                        dispatchGroup.enter()
                        
                        self.loadPokemonDetails(from: entry.url) { result in
                            switch result {
                            case .success(var pokemon):
                                // Cargar la especie del Pokémon
                                self.loadPokemonSpecies(from: pokemon.species.url) { speciesResult in
                                    switch speciesResult {
                                    case .success(let species):
                                        pokemon.speciesData = species // Asignar datos de especie a Pokémon
                                        print("Loaded Pokémon Species: \(species)")
                                        
                                        // Cargar la cadena de evolución para la especie del Pokémon
                                        self.loadEvolutionChain(from: species.evolutionChain.url) { evolutionResult in
                                            switch evolutionResult {
                                            case .success(let evolutions):
                                                print("Loaded Pokémon Evolutions: \(evolutions)")
                                                pokemon.evolutions = evolutions
                                                
                                                // Cargar relaciones de daño
                                                self.loadDamageRelations(for: pokemon) { damageResult in
                                                    switch damageResult {
                                                    case .success(let damageRelations):
                                                        pokemon.damageRelations = damageRelations
                                                    case .failure(let error):
                                                        print("Error al cargar relaciones de daño del Pokémon \(pokemon.name): \(error.localizedDescription)")
                                                    }
                                                    allPokemons.append(pokemon)
                                                    dispatchGroup.leave()
                                                }
                                                
                                            case .failure(let error):
                                                print("Error al cargar evoluciones del Pokémon \(pokemon.name): \(error.localizedDescription)")
                                                dispatchGroup.leave()
                                            }
                                        }
                                        
                                    case .failure(let error):
                                        print("Error al cargar especie del Pokémon \(pokemon.name): \(error.localizedDescription)")
                                        dispatchGroup.leave()
                                    }
                                }
                                
                            case .failure(let error):
                                print("Error al cargar detalles del Pokémon \(entry.name): \(error.localizedDescription)")
                                dispatchGroup.leave()
                            }
                        }
                    }
                    
                    dispatchGroup.notify(queue: .main) {
                        if response.results.count < self.batchSize {
                            // No hay más Pokémon para cargar
                            completion(.success(allPokemons))
                        } else {
                            // Hay más Pokémon, cargar el siguiente lote
                            currentOffset += self.batchSize
                            loadNextBatch()
                        }
                    }
                    
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        
        loadNextBatch()
    }
    
    func searchPokemonbyName(_ name: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(name.lowercased())"
        networkManager.loadData(from: urlString, decodeType: Pokemon.self, completion: completion)
    }
    
    func loadPokemonDetails(from urlString: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        networkManager.loadData(from: urlString, decodeType: Pokemon.self, completion: completion)
    }
    
    func loadPokemonSpecies(from urlString: String, completion: @escaping (Result<PokemonSpecies, Error>) -> Void) {
        networkManager.loadData(from: urlString, decodeType: PokemonSpecies.self, completion: completion)
    }
    
    func loadEvolutionChain(from url: String, completion: @escaping (Result<[PokemonEvolution], Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL inválida."])))
            return
        }
        
        networkManager.loadData(from: url.absoluteString, decodeType: EvolutionChainResponse.self) { result in
            switch result {
            case .success(let response):
                let evolutions = self.parseEvolutions(from: response)
                completion(.success(evolutions))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func loadDamageRelations(for pokemon: Pokemon, completion: @escaping (Result<DamageRelations, Error>) -> Void) {
        guard let typeUrl = pokemon.types.first?.type.url else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No se encontró URL de tipo de Pokémon."])))
            return
        }
        
        networkManager.loadData(from: typeUrl, decodeType: DamageRelationsResponse.self) { result in
            switch result {
            case .success(let response):
                completion(.success(response.damageRelations))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func parseEvolutions(from response: EvolutionChainResponse) -> [PokemonEvolution] {
        var evolutions: [PokemonEvolution] = []
        
        func extractEvolutions(from chain: EvolutionChain, level: Int? = nil, condition: String? = nil) {
            let speciesName = chain.species.name
            let evolution = PokemonEvolution(
                name: speciesName,
                imageURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(speciesName).png"),
                level: level,
                condition: condition
            )
            evolutions.append(evolution)
            
            for evolutionChain in chain.evolvesTo {
                let nextLevel = (level ?? 0) + 1 // Incrementa el nivel para la próxima evolución
                let nextCondition = condition // Mantén la misma condición o actualízala si es necesario
                extractEvolutions(from: evolutionChain, level: nextLevel, condition: nextCondition)
            }
        }
        
        // Inicia el proceso de extracción con la cadena principal
        extractEvolutions(from: response.chain)
        return evolutions
    }
}
