//
//  GetNearbyRestaurantsUseCase.swift
//  PickedApp
//
//  Created by Kevin Heredia on 25/4/25.
//

import Foundation
import CoreLocation

protocol GetNearbyRestaurantsUseCaseProtocol {
    
    var repo: GetNearbyRestaurantsRepositoryProtocol { get set }
    
    func getRestaurantNearby(coordinate: CLLocationCoordinate2D) async throws -> [RestaurantModel]
}

final class GetNearbyRestaurantsUseCase: GetNearbyRestaurantsUseCaseProtocol {
    var repo: GetNearbyRestaurantsRepositoryProtocol
    
    init(repo: GetNearbyRestaurantsRepositoryProtocol = DefaultGetNearbyRestaurantsRepository()) {
        self.repo = repo
    }
    
    func getRestaurantNearby(coordinate: CLLocationCoordinate2D) async throws -> [RestaurantModel] {
        return try await repo.getRestaurantNearby(coordinate: coordinate)
    }
}
