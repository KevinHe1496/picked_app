//
//  NetworkGetNearbyRestaurants.swift
//  PickedApp
//
//  Created by Kevin Heredia on 25/4/25.
//

import Foundation
import CoreLocation

protocol NetworkGetNearbyRestaurantsProtocol {
    func getRestaurantNearby(coordinate: CLLocationCoordinate2D) async throws -> [RestaurantModel]
}

final class NetworkGetNearbyRestaurants: NetworkGetNearbyRestaurantsProtocol {
    func getRestaurantNearby(coordinate: CLLocationCoordinate2D) async throws -> [RestaurantModel] {
        var modelReturn = [RestaurantModel]()
        
        let urlCad = "\(ConstantsApp.CONS_API_URL)\(EndPoints.getNearbyRestaurants.rawValue)"
        
        guard let url = URL(string: urlCad) else {
            throw PKError.badUrl
        }
        
        let requestBody = GetRestaurantNearbyRequest(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let jsonData = try JSONEncoder().encode(requestBody)
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = HttpMethods.post
        request.addValue(HttpMethods.content, forHTTPHeaderField: HttpMethods.contentTypeID)
        let jwtToken = KeyChainPK().loadPK(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
        request.addValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // Verifica que la respuesta sea válida y del tipo HTTPURLResponse.
        guard let httpResponse = response as? HTTPURLResponse else {
            throw PKError.errorFromApi(statusCode: -1)
        }
        
        // Valida que el código de respuesta HTTP sea exitoso.
        guard httpResponse.statusCode == HttpResponseCodes.SUCESS else {
            throw PKError.errorFromApi(statusCode: httpResponse.statusCode)
        }
        
        do {
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
