//
//  EndPoints.swift
//  PickedApp
//
//  Created by Kevin Heredia on 14/4/25.
//

import Foundation

/// Server Side Endpoints
enum EndPoints: String {
    case login = "/auth/login"
    case consumerRegister = "/auth/register-consumer"
    case restaurantRegister = "/register-restaurant"
}
