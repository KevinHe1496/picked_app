//
//  RestaurantDetailModel.swift
//  PickedApp
//
//  Created by Kevin Heredia on 21/4/25.
//

import Foundation

// MARK: - Welcome
struct RestaurantDetailModel: Codable {
    let id: String
    let photo: String
    let address: String
    let country: String
    let meals: [MealModel]
    let name: String
    let city: String
    let zipCode: String
    let info: String
    let latitude, longitude: Double
}

// MARK: - Meal
struct MealModel: Codable {
    let id: String
    let photo: String
    let name: String
    let price: Int
}
