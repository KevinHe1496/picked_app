//
//  NetworkRestaurantDetail.swift
//  PickedApp
//
//  Created by Kevin Heredia on 21/4/25.
//

import Foundation

protocol NetworkRestaurantDetailProtocol {
    func getRestaurantDetail(restaurantId: String) async throws -> RestaurantDetailModel
}

final class NetworkRestaurantDetail: NetworkRestaurantDetailProtocol {
    
    var session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getRestaurantDetail(restaurantId: String) async throws -> RestaurantDetailModel {
        
        var modelReturn = RestaurantDetailModel(id: "", photo: "", address: "", country: "", meals: [Meal(id: UUID(), name: "", info: "", units: 0, price: 0.0, photo: "")], name: "", city: "", zipCode: "", info: "", latitude: 0.0, longitude: 0.0)
        
        let urlCad = "\(ConstantsApp.CONS_API_URL)\(EndPoints.restaurantDetail.rawValue)\(restaurantId)"
        
        guard let url = URL(string: urlCad) else {
            throw PKError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.get
        
        let jwtToken = KeyChainPK().loadPK(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
        request.addValue("Bearer \(jwtToken)", forHTTPHeaderField: "Authorization")
        
        let (data, response) = try await session.data(for: request)
        // Verifica que la respuesta sea válida y del tipo HTTPURLResponse.
        guard let httpResponse = response as? HTTPURLResponse else {
            throw PKError.errorFromApi(statusCode: -1)
        }
        
        // Valida que el código de respuesta HTTP sea exitoso.
        guard httpResponse.statusCode == HttpResponseCodes.SUCESS else {
            throw PKError.errorFromApi(statusCode: httpResponse.statusCode)
        }
        
        do {
            let result = try JSONDecoder().decode(RestaurantDetailModel.self, from: data)
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
