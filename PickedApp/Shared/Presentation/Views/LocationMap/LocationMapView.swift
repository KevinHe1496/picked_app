//
//  LocationMapView.swift
//  PickedApp
//
//  Created by Kevin Heredia on 10/4/25.
//

import SwiftUI
import MapKit

struct LocationMapView: View {
    
    // Coordenadas de ejemplo para la ubicación y anotación
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -0.311557, longitude: -78.456474), // Latitud y longitud de la ubicación
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // El nivel de zoom del mapa
    )
    
    // Lista de anotaciones (marcadores) con ubicaciones
    let annotations = [
        MyAnnotation(title: "Empire State Building", subtitle: "Famous building in NYC", coordinate: CLLocationCoordinate2D(latitude: -0.311557, longitude: -78.456474)),
        MyAnnotation(title: "Statue of Liberty", subtitle: "Famous statue in NYC", coordinate: CLLocationCoordinate2D(latitude: -0.311557, longitude: -78.456474))
    ]
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: annotations) { annotation in
            // Muestra cada anotación como un marcador
            MapPin(coordinate: annotation.coordinate, tint: .blue) // Pin azul
        }
        .ignoresSafeArea() // El mapa ocupa toda la pantalla
        
    }
}

struct MyAnnotation: Identifiable {
    var id = UUID() // Necesario para que las anotaciones sean identificables
    var title: String
    var subtitle: String
    var coordinate: CLLocationCoordinate2D
}

#Preview {
    LocationMapView()
}
