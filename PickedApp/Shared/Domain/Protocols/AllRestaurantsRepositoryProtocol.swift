//
//  AllRestaurantsRepositoryProtocol.swift
//  PickedApp
//
//  Created by Kevin Heredia on 21/4/25.
//

import Foundation

protocol AllRestaurantsRepositoryProtocol {
    func getRestaurants(filter: String) async throws -> [RestaurantModel]
}
