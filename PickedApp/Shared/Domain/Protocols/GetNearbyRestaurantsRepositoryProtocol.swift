//
//  GetNearbyRestaurantsRepositoryProtocol.swift
//  PickedApp
//
//  Created by Kevin Heredia on 25/4/25.
//

import Foundation
import CoreLocation

protocol GetNearbyRestaurantsRepositoryProtocol {
    func getRestaurantNearby(coordinate: CLLocationCoordinate2D) async throws -> [RestaurantModel]
}
