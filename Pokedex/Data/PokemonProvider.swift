//
//  PokemonProvider.swift
//  Pokedex
//
//  Created by Mañanas on 4/9/24.
//

import Foundation

class PokemonProvider {
    
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

