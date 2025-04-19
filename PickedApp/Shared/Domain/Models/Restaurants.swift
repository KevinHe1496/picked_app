//
//  Restaurants.swift
//  PickedApp
//
//  Created by Kevin Heredia on 18/4/25.
//

import Foundation

struct Restaurant:Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let address: String
    let city: String
    let country: String
    let info: String
    let latitude: Double
    let longitude: Double
    let photo: String
    
}

typealias Places = [Restaurant]

