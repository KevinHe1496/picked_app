//
//  RestaurantRegisterView.swift
//  PickedApp
//
//  Created by Kevin Heredia on 8/4/25.
//

import SwiftUI
import PhotosUI

struct RestaurantRegisterView: View {
    
    @State var email = ""
    @State var password = ""
    @State var description = ""
    @State var country = ""
    @State var city = ""
    @State var address = ""
    @State var zipCode = ""
    
    @State private var pickerItems = [PhotosPickerItem]()
    @State private var selectedImages = [Image]()
    
    var body: some View {
        ScrollView {
            VStack{
                Image(.logotipo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Text("Restaurant Register")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                
                VStack(spacing: 10) {
                    
                    IconTextFieldView(iconName: "envelope.fill", placeholder: "Email", text: $email, keyboardType: .emailAddress)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                    
                    IconSecureFieldView(icon: "lock.fill", placeholder: "Password", password: $password)
                    
                    HStack {
                        Image(systemName: "note.text")
                            .foregroundStyle(.secondaryColor)
                            .padding(.bottom, 110)
                        TextEditor(text: $description)
                            .frame(minHeight: 150)
                    }
                    .padding(.horizontal)
                    .background(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                    IconTextFieldView(iconName: "flag.fill", placeholder: "Country", text: $country, keyboardType: .default)
                    
                    IconTextFieldView(iconName: "building.fill", placeholder: "City", text: $city, keyboardType: .default)
                    
                    IconTextFieldView(iconName: "location.fill", placeholder: "Address", text: $address, keyboardType: .default)
                    
                    IconTextFieldView(iconName: "tag.fill", placeholder: "Zip Code", text: $zipCode, keyboardType: .numberPad)
                    
                    VStack {
                        PhotosPicker(selection: $pickerItems, maxSelectionCount: 5 ,matching: .images) {
                            VStack {
                                Text("Take a photo or choose from gallery")
                                    .foregroundStyle(Color.white)
                                Image(systemName: "photo.on.rectangle.angled")
                                    .font(.system(size: 60))
                                    .foregroundStyle(Color.secondaryColor)
                            }
                            
                            .frame(width: 200, height: 200)
                            .shadow(radius: 10)
                            
//                            Label("Select a picture", systemImage: "photo.on.rectangle.angled")
                        }
                        
                        // Mostramos las imagenes seleccionadas
                        ScrollView {
                            ForEach(0..<selectedImages.count, id:\.self) { i in
                                selectedImages[i]
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 300, height: 300)
                                    .padding(3)
                            }
                        }
                    }
                    
                    
                    .onChange(of: pickerItems) { _ , newItems in
                        
                        Task {
                            selectedImages.removeAll()
                            
                            for item in newItems {
                                if let loadedImage = try await item.loadTransferable(type: Image.self) {
                                    selectedImages.append(loadedImage)
                                }
                            }
                        }
                    }
                    
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.primaryColor)
    }
}

#Preview {
    RestaurantRegisterView()
}
