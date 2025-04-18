//
//  ConsumerRegisterRequest.swift
//  PickedApp
//
//  Created by Kevin Heredia on 15/4/25.
//

import Foundation

struct UserLoginRequest: Codable {
    let email: String
    let password: String
}

struct ConsumerRegisterRequest: Codable {
    let name: String
    let email: String
    let password: String
    let role: String
}

struct RestaurantRegisterRequest: Codable {
    let name: String
    let email: String
    let password: String
    let role: String
    let restaurantName: String
    let info: String
    let photo: String
    let address: String
    let country: String
    let city: String
    let zipCode: Int
    let latitude: Double
    let longitude: Double
}
