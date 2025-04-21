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
    
    var filterUI: String = ""
    
    @ObservationIgnored
    private var useCase: AllRestaurantsUseCaseProtocol
    
    init(useCase: AllRestaurantsUseCaseProtocol = AllRestaurantsUseCase()) {
        self.useCase = useCase
        
        Task {
            try await getRestaurants()
        }
    }
    
    @MainActor
    func getRestaurants(newSearch: String = "") async throws {
        let data = try await useCase.getRestaurants(filter: newSearch)
        self.restaurantsData = data
    }
}
