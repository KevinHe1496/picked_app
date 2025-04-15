//
//  NetworkConsumerRegister.swift
//  PickedApp
//
//  Created by Kevin Heredia on 15/4/25.
//

import Foundation

protocol NetworkConsumerRegisterProtocol {
    func consumerRegister(name: String, email: String, password: String, role: String) async throws
}

final class NetworkConsumerRegister: NetworkConsumerRegisterProtocol {
    
    func consumerRegister(name: String, email: String, password: String, role: String) async throws {
        guard let url = URL(string: "\(ConstantsApp.CONS_API_URL)\(EndPoints.consumerRegister.rawValue)") else {
            throw PKError.badUrl
        }
        
        let requestBody = ConsumerRegisterRequest(name: name, email: email, password: password, role: role)
        let jsonData = try JSONEncoder().encode(requestBody)
        
        var request = URLRequest(url: url)
        request.httpMethod = HttpMethods.post
        request.setValue(HttpMethods.content, forHTTPHeaderField: HttpMethods.contentTypeID)
        request.httpBody = jsonData
        
        do {
            let (_, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw PKError.errorFromApi(statusCode: -1)
            }
            guard httpResponse.statusCode == HttpResponseCodes.SUCESS else {
                throw PKError.errorFromApi(statusCode: httpResponse.statusCode)
            }
        } catch {
            print("Error registring Consumer \(error.localizedDescription)")
        }
    }
}
