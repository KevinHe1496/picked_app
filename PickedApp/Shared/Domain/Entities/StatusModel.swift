//
//  StatusModel.swift
//  PickedApp
//
//  Created by Kevin Heredia on 14/4/25.
//

import Foundation

enum Status {
    case none, loading, login, register, loaded, error(error: String)
}
