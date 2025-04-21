//
//  DetaultRestaurantDetailRepository.swift
//  PickedApp
//
//  Created by Kevin Heredia on 21/4/25.
//

import Foundation

final class DetaultRestaurantDetailRepository: RestaurantDetailRepositoryProtocol {
    private var network: NetworkRestaurantDetailProtocol
    
    init(network: NetworkRestaurantDetailProtocol = NetworkRestaurantDetail()) {
        self.network = network
    }
    
    func getRestaurantDetail(restaurantId: String) async throws -> RestaurantDetailModel {
        return try await network.getRestaurantDetail(restaurantId: restaurantId)
    }
}
