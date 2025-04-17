//
//  RestaurantResgisterViewModel.swift
//  PickedApp
//
//  Created by Kevin Heredia on 17/4/25.
//

import Foundation

@Observable
final class RestaurantResgisterViewModel {
    var address: String = ""
    var latitude: Double?
    var longitude: Double?
    var isLoading: Bool = false
    var errorMessage: String?
    
    @ObservationIgnored
    private let useCase: RestaurantRegisterUseCaseProtocol
    
    init(useCase: RestaurantRegisterUseCaseProtocol = RestaurantRegisterUseCase()) {
        self.useCase = useCase
    }
}
