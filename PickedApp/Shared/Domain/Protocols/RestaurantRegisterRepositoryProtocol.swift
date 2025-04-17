//
//  RestaurantRegisterRepositoryProtocol.swift
//  PickedApp
//
//  Created by Kevin Heredia on 17/4/25.
//

import Foundation

protocol RestaurantRegisterRepositoryProtocol {
    func restaurantRegister(
        name: String,
        email: String,
        password: String,
        role: String,
        restaurantName: String,
        info: String,
        photo: String,
        address: String,
        country: String,
        city: String,
        zipCode: Int,
        latitude: Double,
        longitude: Double
    )
    async throws
    -> Bool
}
