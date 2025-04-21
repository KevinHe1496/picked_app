//
//  Data-extesion.swift
//  PickedApp
//
//  Created by Kevin Heredia on 18/4/25.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}

func createMultipartBody(from formData: RestaurantRegisterRequest, boundary: String) throws -> Data {
    
    var body = Data()
    
    // Helper para añadir campos de texto al body
    func addField(_ name: String, value: String?) {
        guard let value = value, !value.isEmpty else { return }
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(value)\r\n".data(using: .utf8)!)
    }
    
    // Añadir los campos del formulario
    addField("email", value: formData.email)
    addField("password", value: formData.password)
    addField("role", value: formData.role)
    addField("restaurantName", value: formData.restaurantName)
    addField("info", value: formData.info)
    addField("address", value: formData.address)
    addField("country", value: formData.country)
    addField("city", value: formData.city)
    addField("zipCode", value: formData.zipCode)
    addField("latitude", value: String(formData.latitude))
    addField("longitude", value: String(formData.longitude))
    addField("name", value: formData.name)
    
    // Añadir la imagen si existe
    if let imageData = formData.photo {
        print("📸 Imagen añadida: \(imageData.count) bytes")
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"photo\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
    } else {
        print("⚠️ No hay imagen que añadir al body")
    }
    
    body.append("--\(boundary)--\r\n".data(using: .utf8)!)
    
    return body
}
