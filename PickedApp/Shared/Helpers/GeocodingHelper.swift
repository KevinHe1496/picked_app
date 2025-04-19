//
//  GeocodingHelper.swift
//  PickedApp
//
//  Created by Kevin Heredia on 17/4/25.
//


import Foundation
import CoreLocation

struct GeocodingHelper {
    static func getCoordinates(for address: String) async throws -> CLLocationCoordinate2D {
        return try await withCheckedThrowingContinuation { continuation in
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(address) { placemarks, error in
                if let error = error {
                    print("❌ Error al geocodificar dirección: \(error)")
                    continuation.resume(throwing: error)
                } else if let coordinate = placemarks?.first?.location?.coordinate {
                    print("✅ Coordenadas obtenidas: \(coordinate)")
                    continuation.resume(returning: coordinate)
                } else {
                    let geocodeError = NSError(
                        domain: "GeocodingError",
                        code: 1,
                        userInfo: [NSLocalizedDescriptionKey: "No se encontraron coordenadas para la dirección."]
                    )
                    print("❌ No se encontraron coordenadas: \(geocodeError.localizedDescription)")
                    continuation.resume(throwing: geocodeError)
                }
            }
        }
    }
}

