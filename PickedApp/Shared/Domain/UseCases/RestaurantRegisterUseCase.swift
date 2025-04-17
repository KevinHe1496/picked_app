//
//  RestaurantRegisterUseCase.swift
//  PickedApp
//
//  Created by Kevin Heredia on 17/4/25.
//

import Foundation

protocol RestaurantRegisterUseCaseProtocol {
    var repo: RestaurantRegisterRepositoryProtocol { get set }
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
    -> Bool
}

final class RestaurantRegisterUseCase: RestaurantRegisterUseCaseProtocol {
    var repo: RestaurantRegisterRepositoryProtocol
    
    init(repo: RestaurantRegisterRepositoryProtocol = DefaultRestaurantRepository()) {
        self.repo = repo
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
        return try await repo.restaurantRegister(
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
    }
}

final class RestaurantRegisterUseCaseMock: RestaurantRegisterUseCaseProtocol {
    var repo: RestaurantRegisterRepositoryProtocol
    
    init(repo: RestaurantRegisterRepositoryProtocol = DefaultRestaurantRepositoryMock()) {
        self.repo = repo
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
        return try await repo.restaurantRegister(
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
    }
}

final class RestaurantRegisterUseCaseFailureMock: RestaurantRegisterUseCaseProtocol {
    var repo: RestaurantRegisterRepositoryProtocol
    
    init(repo: RestaurantRegisterRepositoryProtocol = DefaultRestaurantRepositoryFailureMock()) {
        self.repo = repo
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
        return try await repo.restaurantRegister(
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
    }
}
