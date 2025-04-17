//
//  DefaultRestaurantRepository.swift
//  PickedApp
//
//  Created by Kevin Heredia on 17/4/25.
//

import Foundation

final class DefaultRestaurantRepository: RestaurantRegisterRepositoryProtocol {
    private var network: NetworkRestaurantRegisterProtocol
    
    init(network: NetworkRestaurantRegisterProtocol = NetworkRestaurantRegister()) {
        self.network = network
    }
    
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
    ) async throws -> Bool {
        do {
            try await network
                .restaurantRegister(
                    name: name,
                    email: email,
                    password: password,
                    role: role,
                    restaurantName: restaurantName,
                    info: info,
                    photo: photo,
                    address: address,
                    country: country,
                    city: city,
                    zipCode: zipCode,
                    latitude: latitude,
                    longitude: longitude
                )
            return true
        } catch {
            throw error
        }
    }
}


final class DefaultRestaurantRepositoryMock: RestaurantRegisterRepositoryProtocol {
    private var network: NetworkRestaurantRegisterProtocol
    
    init(network: NetworkRestaurantRegisterProtocol = NetworkRestaurantRegisterMock()) {
        self.network = network
    }
    
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
    ) async throws -> Bool {
        do {
            try await network
                .restaurantRegister(
                    name: name,
                    email: email,
                    password: password,
                    role: role,
                    restaurantName: restaurantName,
                    info: info,
                    photo: photo,
                    address: address,
                    country: country,
                    city: city,
                    zipCode: zipCode,
                    latitude: latitude,
                    longitude: longitude
                )
            return true
        } catch {
            throw error
        }
    }
}


final class DefaultRestaurantRepositoryFailureMock: RestaurantRegisterRepositoryProtocol {
    private var network: NetworkRestaurantRegisterProtocol
    
    init(network: NetworkRestaurantRegisterProtocol = NetworkRestaurantRegisterFailureMock()) {
        self.network = network
    }
    
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
    ) async throws -> Bool {
        throw PKError.errorFromApi(statusCode: 400)
    }
}
