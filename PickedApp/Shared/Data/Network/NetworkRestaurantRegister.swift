//
//  NetworkRestaurantRegister.swift
//  PickedApp
//
//  Created by Kevin Heredia on 17/4/25.
//

import Foundation

protocol NetworkRestaurantRegisterProtocol {
    func restaurantRegister(
        name: String,
        email: String,
        password: String,
        role: String,
        restaurantName: String,
        info: String,
        photo: String,
        address: String,
        country: String,
        city: String,
        zipCode: Int,
        latitude: Double,
        longitude: Double
    )
    async throws
}

final class NetworkRestaurantRegister: NetworkRestaurantRegisterProtocol {
    func restaurantRegister(
        name: String,
        email: String,
        password: String,
        role: String,
        restaurantName: String,
        info: String,
        photo: String,
        address: String,
        country: String,
        city: String,
        zipCode: Int,
        latitude: Double,
        longitude: Double
    ) async throws {
        guard let url = URL(string: "\(ConstantsApp.CONS_API_URL)\(EndPoints.restaurantRegister.rawValue)") else {
            throw PKError.badUrl
        }
        
        let requestBody = RestaurantRegisterRequest(name: name, email: email, password: password, role: role, restaurantName: restaurantName, info: info, photo: photo, address: address, country: country, city: city, zipCode: zipCode, latitude: latitude, longitude: longitude)
        let jsonData = try JSONEncoder().encode(requestBody)
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.post
        request.setValue(HttpMethods.content, forHTTPHeaderField: HttpMethods.contentTypeID)
        request.httpBody = jsonData
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw PKError.errorFromApi(statusCode: -1)
            }
            
            guard httpResponse.statusCode == HttpResponseCodes.SUCESS else {
                throw PKError.errorFromApi(statusCode: httpResponse.statusCode)
            }
        } catch {
            print("Error registering restaurant \(error.localizedDescription)")
        }
    }
}

final class NetworkRestaurantRegisterMock: NetworkRestaurantRegisterProtocol {
    func restaurantRegister(name: String, email: String, password: String, role: String, restaurantName: String, info: String, photo: String, address: String, country: String, city: String, zipCode: Int, latitude: Double, longitude: Double) async throws {
        print("Mock success")
    }
}

final class NetworkRestaurantRegisterFailureMock: NetworkRestaurantRegisterProtocol {
    func restaurantRegister(name: String, email: String, password: String, role: String, restaurantName: String, info: String, photo: String, address: String, country: String, city: String, zipCode: Int, latitude: Double, longitude: Double) async throws {
        throw PKError.errorFromApi(statusCode: 400)
    }
}
