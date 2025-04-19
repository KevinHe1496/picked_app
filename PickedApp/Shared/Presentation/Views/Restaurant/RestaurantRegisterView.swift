//
//  RestaurantRegisterView.swift
//  PickedApp
//
//  Created by Kevin Heredia on 8/4/25.
//

import SwiftUI
import PhotosUI

/// A view that displays a registration form for restaurants.
struct RestaurantRegisterView: View {
    
    // MARK: - User Input State
    @State var email = "Anthonelarestaurante@example.com"
    @State var password = "123456"
    @State var info = "Restaurante Placos tipicos"
    @State var country = "Ecuador"
    @State var city = "Quito"
    @State var address = "Av. Amazonas y Av. Patria"
    @State var zipCode = "170507"
    @State var name = "Anthonela"
    @State var role = "restaursant"
    @State var restaurantName = "Mi restaurante Ecuador"
    
    // MARK: - Image Picker State
    @State private var pickerItem: PhotosPickerItem? = nil
    @State private var selectedImage: Image? = nil
    @State private var selectedPhotoData: Data?
    @State private var network = NetworkRestaurantRegister()
    
    var body: some View {
        ScrollView {
            VStack {
                
                // App logo
                Image(.logotipo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                // Screen title
                Text("Restaurant Register")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 10) {
                    
                    // Email field
                    IconTextFieldView(
                        iconName: "envelope.fill",
                        placeholder: "Email",
                        text: $email,
                        keyboardType: .emailAddress
                    )
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    
                    // Password field
                    IconSecureFieldView(
                        icon: "lock.fill",
                        placeholder: "Password",
                        password: $password
                    )
                    
                    // Description field
                    HStack {
                        Image(systemName: "note.text")
                            .foregroundStyle(.secondaryColor)
                            .padding(.bottom, 110)
                        
                        TextEditor(text: $info)
                            .frame(minHeight: 150)
                            .padding(5)
                    }
                    .padding(.horizontal)
                    .background(Color(.systemBackground))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    // Address-related fields
                    IconTextFieldView(iconName: "flag.fill", placeholder: "Country", text: $country, keyboardType: .default)
                    IconTextFieldView(iconName: "building.fill", placeholder: "City", text: $city, keyboardType: .default)
                    IconTextFieldView(iconName: "location.fill", placeholder: "Address", text: $address, keyboardType: .default)
                    IconTextFieldView(iconName: "tag.fill", placeholder: "Zip Code", text: $zipCode, keyboardType: .default)
                    
                    // Image picker section
                    VStack {
                        PhotosPicker(selection: $pickerItem, matching: .images) {
                            VStack {
                                Text("Take a photo or choose from gallery")
                                    .foregroundStyle(Color.secondaryColor)
                                Image(systemName: "photo.on.rectangle.angled")
                                    .font(.system(size: 60))
                                    .foregroundStyle(Color.secondaryColor)
                            }
                        }
                    }
                    .padding()
                    .frame(width: 200, height: 200)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    CustomButtonView(title: "Register", color: .secondaryColor) {
                        print("🔘 Botón presionado")

                        Task {
                            do {
                                try await network.restaurantRegister(from: RestaurantRegisterRequest(email: email, password: password, role: "restaurant", restaurantName: restaurantName, info: info, address: address, country: country, city: city, zipCode: zipCode, latitude: 0.0, longitude: 0.0, name: name, photo: selectedPhotoData))
                            } catch {
                                print("❌ Error en el registro: \(error)")
                            }
                        }
                    }
                    
                    
                }
                // Handle changes in the image picker
                .onChange(of: pickerItem) { _, newItem in
                    Task {
                        if let selectedItem = newItem {
                            do {
                                // Load the selected photo data
                                if let data = try await selectedItem.loadTransferable(type: Data.self) {
                                    // Store the data in the selectedPhotoData variable
                                    self.selectedPhotoData = data
                                    print("✅ Image loaded with size: \(data.count) bytes")
                                }
                            } catch {
                                print("❌ Error loading image: \(error)")
                            }
                        }
                    }
                }
            }
        }
        .scrollIndicators(.never)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.primaryColor)
    }
}


#Preview {
    RestaurantRegisterView()
}
