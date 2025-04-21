//
//  RestaurantDetailUseCase.swift
//  PickedApp
//
//  Created by Kevin Heredia on 21/4/25.
//

import Foundation

protocol RestaurantDetailUseCaseProtocol {
    var repo: RestaurantDetailRepositoryProtocol { get set }
    func getRestaurantDetail(restaurantId: String) async throws -> RestaurantDetailModel
}

final class RestaurantDetailUseCase: RestaurantDetailUseCaseProtocol {
    var repo: RestaurantDetailRepositoryProtocol
    
    init(repo: RestaurantDetailRepositoryProtocol = DetaultRestaurantDetailRepository()) {
        self.repo = repo
    }
    
    func getRestaurantDetail(restaurantId: String) async throws -> RestaurantDetailModel {
        return try await repo.getRestaurantDetail(restaurantId: restaurantId)
    }
}
