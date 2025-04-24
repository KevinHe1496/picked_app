//
//  DefaultAllRestaurantsRepository.swift
//  PickedApp
//
//  Created by Kevin Heredia on 21/4/25.
//

import Foundation

final class DefaultAllRestaurantsRepository: AllRestaurantsRepositoryProtocol {
    
    private var network: NetworkAllRestaurantsProtocol
    
    init(network: NetworkAllRestaurantsProtocol = NetworkAllRestaurants()) {
        self.network = network
    }
    
    func getRestaurants() async throws -> [RestaurantModel] {
        return try await network.getRestaurants()
    }
}

// MOCK SUCCESS
final class DefaultAllRestaurantsRepositorySuccessMock: AllRestaurantsRepositoryProtocol {
    
    private var network: NetworkAllRestaurantsProtocol
    
    init(network: NetworkAllRestaurantsProtocol = NetworkAllRestaurantsSuccessMock()) {
        self.network = network
    }
    
    func getRestaurants() async throws -> [RestaurantModel] {
        try await network.getRestaurants()
    }
}
// MOCK FAILURE
final class DefaultAllRestaurantsRepositoryFailureMock: AllRestaurantsRepositoryProtocol {
    
    private var network: NetworkAllRestaurantsProtocol
    
    init(network: NetworkAllRestaurantsProtocol = NetworkAllRestaurantsFailureMock()) {
        self.network = network
    }
    
    func getRestaurants() async throws -> [RestaurantModel] {
        throw PKError.badUrl
    }
}
