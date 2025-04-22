//
//  AllRestaurantsUseCase.swift
//  PickedApp
//
//  Created by Kevin Heredia on 21/4/25.
//

import Foundation

protocol AllRestaurantsUseCaseProtocol {
    var repo: AllRestaurantsRepositoryProtocol { get set }
    func getRestaurants() async throws -> [RestaurantModel]
}

final class AllRestaurantsUseCase: AllRestaurantsUseCaseProtocol {
    var repo: AllRestaurantsRepositoryProtocol
    
    init(repo: AllRestaurantsRepositoryProtocol = DefaultAllRestaurantsRepository()) {
        self.repo = repo
    }
    
    func getRestaurants() async throws -> [RestaurantModel] {
        return try await repo.getRestaurants()
    }
}
