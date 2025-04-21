//
//  RestaurantResgisterViewModel.swift
//  PickedApp
//
//  Created by Kevin Heredia on 17/4/25.
//

import Foundation
import CoreLocation
import PhotosUI
import SwiftUI

@Observable
final class RestaurantResgisterViewModel {
    
    private var appState: AppStateVM
    var address: String = ""
    var latitude: Double?
    var longitude: Double?
    var isLoading: Bool = false
    var errorMessage: String?
    var tokenJWT: String = ""
    var isRegistered: Bool = false
    
    @ObservationIgnored
    private let useCase: RestaurantRegisterUseCaseProtocol
    
    init(useCase: RestaurantRegisterUseCaseProtocol = RestaurantRegisterUseCase(), appState: AppStateVM) {
        self.useCase = useCase
        self.appState = appState
    }
    
    /// Envia el formulario utilizando el caso de uso.
    func restaurantRegister(
        email: String,
        password: String,
        role: String,
        restaurantName: String,
        info: String,
        address: String,
        country: String,
        city: String,
        zipCode: String,
        name: String,
        photo: Data?
    ) async throws -> String? {
        
        guard !address.isEmpty else {
            self.errorMessage = "La dirección no puede estar vacía"
            return errorMessage
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            // Obtener coordenadas
            let coordinates = try await GeocodingHelper.getCoordinates(
                street: address,
                zipCode: zipCode,
                city: city,
                country: country
            )
            print("✅ Coordenadas obtenidas: Latitud: \(coordinates.latitude), Longitud: \(coordinates.longitude)")
            self.latitude = coordinates.latitude
            self.longitude = coordinates.longitude
            
            
            let formData = RestaurantRegisterRequest(
                email: email,
                password: password,
                role: role,
                restaurantName: restaurantName,
                info: info,
                address: address,
                country: country,
                city: city,
                zipCode: zipCode,
                latitude: coordinates.latitude,
                longitude: coordinates.longitude,
                name: name,
                photo: photo
            )
            
            let result = try await useCase.restaurantRegister(formData: formData)
            
            if result {
                appState.status = .loaded
                isLoading = false
                return nil
            } else {
                appState.status = .error(error: "Incorrect form")
                isLoading = false
                return "Incorrect"
            }
            
        } catch {
            self.errorMessage = "Error al registrar el restaurante: \(error.localizedDescription)"
            return "Something went wrong."
        }
    }
  
}
