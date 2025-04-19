//
//  NetworkRestaurantRegister.swift
//  PickedApp
//
//  Created by Kevin Heredia on 17/4/25.
//

import Foundation

protocol NetworkRestaurantRegisterProtocol {
    func restaurantRegister(from formData: RestaurantRegisterRequest) async throws -> String
}

final class NetworkRestaurantRegister: NetworkRestaurantRegisterProtocol {
    
    func restaurantRegister(from formData: RestaurantRegisterRequest) async throws -> String {
        var tokenJWT = ""
        
        guard let url = URL(string: "\(ConstantsApp.CONS_API_URL)\(EndPoints.restaurantRegister.rawValue)") else {
            throw PKError.badUrl
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.post
        
        // Genera un boundary único válido
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let body = try createMultipartBody(from: formData, boundary: boundary)

        request.httpBody = body
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw PKError.errorFromApi(statusCode: -1)
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                print("✅ Respuesta: \(responseString)")
            }
            
            guard httpResponse.statusCode == HttpResponseCodes.SUCESS else {
                throw PKError.errorFromApi(statusCode: httpResponse.statusCode)
            }
            
            let result  = try JSONDecoder().decode(User.self, from: data)
            tokenJWT = result.token
        } catch {
            print("Error registering Restaurant \(error.localizedDescription)")
        }
        return tokenJWT
    }
}

final class NetworkRestaurantRegisterMock: NetworkRestaurantRegisterProtocol {
    func restaurantRegister(from formData: RestaurantRegisterRequest) async throws -> String {
        return "mockToken"
    }
}

final class NetworkRestaurantRegisterFailureMock: NetworkRestaurantRegisterProtocol {
    func restaurantRegister(from formData: RestaurantRegisterRequest) async throws -> String {
        throw PKError.errorFromApi(statusCode: 400)
    }
}
