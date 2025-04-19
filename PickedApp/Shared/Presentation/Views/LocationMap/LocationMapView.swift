//
//  LocationMapView.swift
//  PickedApp
//
//  Created by Kevin Heredia on 10/4/25.
//

//
//  LocationMapView.swift
//  PickedApp
//
//  Created by Kevin Heredia on 10/4/25.
//

import SwiftUI
import MapKit

struct LocationMapView: View {
    @StateObject private var locationManager = LocationManager()

    // Posición del mapa que se actualiza cuando la ubicación está disponible
    @State private var cameraPosition: MapCameraPosition = .automatic

    let restaurants: [Restaurant]

    var body: some View {
        Map(position: $cameraPosition) {
            
            // Marcador para el usuario
            UserAnnotation()

            // Marcadores de restaurantes
            ForEach(restaurants) { restaurant in
                Annotation(restaurant.name, coordinate: restaurant.coordinate) {
                    VStack {
                        Image(systemName: "mappin.circle.fill")
                            .foregroundColor(.red)
                            .font(.title)
                        Text(restaurant.name)
                            .font(.caption)
                            .fixedSize()
                            .padding(4)
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(5)
                    }
                }
            }
        }
        .mapControls {
            MapUserLocationButton() // Botón para centrar en la ubicación del usuario
            MapCompass()
        }
        .onChange(of: locationManager.userLocation) { (oldLocation, newLocation) in
            if let newCoordinate = newLocation {
                // Actualizamos la posición del mapa con la nueva ubicación del usuario
                cameraPosition = .region(
                    MKCoordinateRegion(
                        center: newCoordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    )
                )
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LocationMapView(restaurants: previewRestaurants)
}



