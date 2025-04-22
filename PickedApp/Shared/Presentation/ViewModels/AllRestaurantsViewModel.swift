//
//  AllRestaurantsViewModel.swift
//  PickedApp
//
//  Created by Kevin Heredia on 21/4/25.
//

import Foundation

@Observable
final class AllRestaurantsViewModel {
    var restaurantsData = [RestaurantModel]()
    
    var search: String = ""
    
    var restaurantFilter: [RestaurantModel] {
        if search.isEmpty {
            restaurantsData
        } else {
            restaurantsData.filter { restaurant in
                restaurant.name.localizedStandardContains(search)
            }
        }
    }
    
    @ObservationIgnored
    private var useCase: AllRestaurantsUseCaseProtocol
    
    init(useCase: AllRestaurantsUseCaseProtocol = AllRestaurantsUseCase()) {
        self.useCase = useCase
        
        Task {
            try await getRestaurants()
        }
    }
    
    @MainActor
    func getRestaurants() async throws {
        let data = try await useCase.getRestaurants()
        self.restaurantsData = data
    }
}
