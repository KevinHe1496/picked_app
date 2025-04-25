//
//  GetNearbyRestaurantViewModel.swift
//  PickedApp
//
//  Created by Kevin Heredia on 25/4/25.
//

import Foundation
import CoreLocation

@Observable
final class GetNearbyRestaurantViewModel {
    
    var locationService = LocationService()
    var restaurantsNearby = [RestaurantModel]()
    var search: String = ""
    
    var restaurantFilter: [RestaurantModel] {
        if search.isEmpty {
            restaurantsNearby
        } else {
            restaurantsNearby.filter { restaurant in
                restaurant.name.localizedStandardContains(search)
            }
        }
    }

    @ObservationIgnored
    private var useCase: GetNearbyRestaurantsUseCaseProtocol
    
    init(useCase: GetNearbyRestaurantsUseCaseProtocol = GetNearbyRestaurantsUseCase()) {
        self.useCase = useCase
    }
    
    @MainActor
    func getNearbyRestaurants() async throws {
        let coordinates = try await locationService.requestLocation()
        let result = try await useCase.getRestaurantNearby(coordinate: coordinates)
        restaurantsNearby = result
    }
}
