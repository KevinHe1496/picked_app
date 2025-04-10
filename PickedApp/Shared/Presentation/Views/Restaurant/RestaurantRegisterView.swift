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
    @State var email = ""
    @State var password = ""
    @State var description = ""
    @State var country = ""
    @State var city = ""
    @State var address = ""
    @State var zipCode = ""
    
    // MARK: - Image Picker State
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
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
                        
                        TextEditor(text: $description)
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
                    IconTextFieldView(iconName: "tag.fill", placeholder: "Zip Code", text: $zipCode, keyboardType: .numberPad)
                    
                    // Image picker section
                    VStack {
                        PhotosPicker(selection: $pickerItems, maxSelectionCount: 5, matching: .images) {
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
                    
                    // Show selected images
                    ForEach(0..<selectedImages.count, id: \.self) { i in
                        selectedImages[i]
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300, height: 300)
                            .padding(3)
                    }
                    
                    // Handle changes in the image picker
                    .onChange(of: pickerItems) { _, newItems in
                        Task {
                            selectedImages.removeAll()
                            for item in newItems {
                                if let loadedImage = try await item.loadTransferable(type: Image.self) {
                                    selectedImages.append(loadedImage)
                                }
                            }
                        }
                    }
                    
                    // Register button
                    CustomButtonView(title: "Register", color: .secondaryColor) {
                        // Handle registration logic here
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
