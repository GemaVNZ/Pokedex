//
//  PokemonProvider.swift
//  Pokedex
//
//  Created by Mañanas on 4/9/24.
//

import Foundation

class PokemonProvider {
    
    func loadAllPokemons(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
            let urlString = "https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0"
            
            guard let url = URL(string: urlString) else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL inválida"])
                completion(.failure(error))
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error de red: \(error.localizedDescription)")
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No se recibió ningún dato"])
                    completion(.failure(error))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(PokemonListResponse.self, from: data)
                    
                    // Crear un grupo de despacho para manejar la carga de detalles de Pokémon
                    let dispatchGroup = DispatchGroup()
                    var pokemons: [Pokemon] = []
                    
                    for entry in response.results {
                        dispatchGroup.enter()
                        
                        self.loadPokemonDetails(from: entry.url) { result in
                            switch result {
                            case .success(let pokemon):
                                pokemons.append(pokemon)
                            case .failure(let error):
                                print("Error al cargar detalles del Pokémon \(entry.name): \(error.localizedDescription)")
                            }
                            dispatchGroup.leave()
                        }
                    }
                    
                    dispatchGroup.notify(queue: .main) {
                        completion(.success(pokemons))
                    }
                    
                } catch {
                    print("Error al decodificar la respuesta JSON: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
        
        // Nueva función para cargar los detalles de un Pokémon específico
    func loadPokemonDetails(from urlString: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {
            guard let url = URL(string: urlString) else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL inválida"])
                completion(.failure(error))
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Error de red: \(error.localizedDescription)")
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No se recibió ningún dato"])
                    completion(.failure(error))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let pokemon = try decoder.decode(Pokemon.self, from: data)
                    completion(.success(pokemon))
                } catch {
                    print("Error al decodificar los detalles del Pokémon: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    
    func searchPokemonbyName(_ name: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(name.lowercased())"
        
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL inválida"])
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error de red: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No se recibió ningún dato"])
                completion(.failure(error))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let pokemon = try decoder.decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                print("Error al decodificar la respuesta JSON: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

