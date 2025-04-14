//
//  User.swift
//  PickedApp
//
//  Created by Kevin Heredia on 14/4/25.
//

import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    let name: String
    let email: String
    let role: String
    let token: String
}
