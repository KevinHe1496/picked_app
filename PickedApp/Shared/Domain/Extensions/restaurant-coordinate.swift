//
//  restaurant-coordinate.swift
//  PickedApp
//
//  Created by Kevin Heredia on 18/4/25.
//

import Foundation
import CoreLocation

extension Restaurant {
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
