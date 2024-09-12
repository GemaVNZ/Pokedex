//
//  NetworkManager.swift
//  Pokedex
//
//  Created by Mañanas on 11/9/24.
//

import Foundation

class NetworkManager {
    
    private func performRequest<T: Decodable>(with url: URL, decodeType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error de red: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
                let error = NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: "Respuesta del servidor no válida. Código de estado: \(statusCode)"])
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No se recibió ningún dato"])
                completion(.failure(error))
                return
            }
            
            // Imprime los datos para depuración
            if let dataString = String(data: data, encoding: .utf8) {
                print("Datos recibidos:\n\(dataString)")
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedObject = try decoder.decode(decodeType, from: data)
                completion(.success(decodedObject))
            } catch {
                print("Error al decodificar: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
    
    func loadData<T: Codable>(from urlString: String, decodeType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "URL inválida"])))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Datos nulos"])))
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(decodeType, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
