import SwiftUI
import _MapKit_SwiftUI

// Vista que muestra el mapa con la ubicación del usuario y los restaurantes cercanos.
struct LocationMapView: View {
    
    @State var viewModel: GetNearbyRestaurantViewModel // ViewModel que maneja la lógica del mapa.
    
    // Inicializa la vista con un ViewModel opcional.
    init(viewModel: GetNearbyRestaurantViewModel = GetNearbyRestaurantViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        Map(position: $viewModel.cameraPosition) {
            
            // Marcador que muestra la ubicación actual del usuario.
            UserAnnotation()
            
            // Marcadores de cada restaurante en el mapa.
            ForEach(viewModel.restaurantsNearby) { restaurant in
                Annotation(restaurant.name, coordinate: restaurant.coordinate) {
                    Button {
                        viewModel.selectRestaurant(restaurant) // Selecciona un restaurante al pulsar.
                    } label: {
                        RestaurantAnnotationView(restaurant: restaurant) // Vista personalizada del marcador.
                    }
                }
            }
        }
        .onAppear {
            Task {
             try await viewModel.loadData() // Carga ubicación y restaurantes al aparecer la vista.
            }
        }
        .sheet(item: $viewModel.selectedRestaurant) { restaurant in
            RestaurantSelectedMapDetailView(restaurant: restaurant) // Muestra detalle del restaurante seleccionado.
                .presentationDetents([.medium])
        }
        .mapControls {
            MapUserLocationButton() // Botón para centrar el mapa en la ubicación del usuario.
            MapCompass() // Muestra una brújula en el mapa.
        }
        .edgesIgnoringSafeArea(.top) // Extiende el mapa hasta los bordes superiores.
        .ignoresSafeArea() // Ignora todos los márgenes seguros para el mapa.
    }
}

// Vista previa para SwiftUI.
#Preview {
    LocationMapView()
}
