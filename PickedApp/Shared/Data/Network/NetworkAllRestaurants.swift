//
//  NetworkAllRestaurants.swift
//  PickedApp
//
//  Created by Kevin Heredia on 21/4/25.
//

import Foundation

protocol NetworkAllRestaurantsProtocol {
    func getRestaurants(filter: String) async throws -> [RestaurantModel]
}

final class NetworkAllRestaurants: NetworkAllRestaurantsProtocol {
    
    func getRestaurants(filter: String) async throws -> [RestaurantModel] {
        var modelReturn = [RestaurantModel]()
        
        let urlCad = "\(ConstantsApp.CONS_API_URL)\(EndPoints.allRestaurants.rawValue)"
        
        guard let url = URL(string: urlCad) else {
            throw PKError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.get
        
        let jwtToken = KeyChainPK().loadPK(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
        request.addValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data,response) = try await URLSession.shared.data(for: request)
            
            // Verifica que la respuesta sea válida y del tipo HTTPURLResponse.
            guard let httpResponse = response as? HTTPURLResponse else {
                throw PKError.errorFromApi(statusCode: -1)
            }
            
            // Imprime la respuesta en formato string para depuración.
            if let responseString = String(data: data, encoding: .utf8) {
                print("✅ Respuesta: \(responseString)")
            }
            
            // Valida que el código de respuesta HTTP sea exitoso.
            guard httpResponse.statusCode == HttpResponseCodes.SUCESS else {
                throw PKError.errorFromApi(statusCode: httpResponse.statusCode)
            }
            
            let result = try JSONDecoder().decode([RestaurantModel].self, from: data)
            modelReturn = result
            
        } catch {
            print("Decoding error: \(error)")
            if let decodingError = error as? DecodingError {
                switch decodingError {
                case .keyNotFound(let key, let context):
                    print("🔑 Key '\(key)' not found: \(context.debugDescription)")
                case .typeMismatch(let type, let context):
                    print("🚫 Type mismatch for type '\(type)': \(context.debugDescription)")
                case .valueNotFound(let value, let context):
                    print("❌ Value '\(value)' not found: \(context.debugDescription)")
                case .dataCorrupted(let context):
                    print("💥 Data corrupted: \(context.debugDescription)")
                @unknown default:
                    print("❓ Unknown decoding error")
                }
            }
        }
        
        return modelReturn
    }
}
