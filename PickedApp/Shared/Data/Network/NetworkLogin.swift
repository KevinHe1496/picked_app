//
//  NetworkLogin.swift
//  PickedApp
//
//  Created by Kevin Heredia on 14/4/25.
//

import Foundation

protocol NetworkLoginProtocol {
    func loginUser(user: String, password: String) async throws -> String
}

final class NetworkLogin: NetworkLoginProtocol {
    func loginUser(user: String, password: String) async throws -> String {
        var tokenJWT = ""
        let urlCad = "\(ConstantsApp.CONS_API_URL)\(EndPoints.login.rawValue)"
        
        guard let url = URL(string: urlCad) else {
            throw PKError.badUrl
        }
        
//        guard let encodeCredentials = "\(user):\(password)".data(using: .utf8)?.base64EncodedString() else {
//            throw PKError.authenticationFailed
//        }
        
        let body: [String: String] = [
            "email": user,
            "password": password
        ]
        
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = HttpMethods.post
        request.addValue(HttpMethods.content, forHTTPHeaderField: HttpMethods.contentTypeID)
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
//        request.addValue("Basic \(encodeCredentials)", forHTTPHeaderField: "Authorization")
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw PKError.errorFromApi(statusCode: -1)
            }
            guard httpResponse.statusCode == HttpResponseCodes.SUCESS else {
                let errorBody = String(data: data, encoding: .utf8) ?? "Respuesta no legible"
                  print("Código de error: \(httpResponse.statusCode)")
                  print("Cuerpo del error: \(errorBody)")
                throw PKError.errorFromApi(statusCode: httpResponse.statusCode)
            }
            
            let result = try JSONDecoder().decode(User.self, from: data)
            tokenJWT = result.token
        } catch {
            print("error fetching user \(error.localizedDescription)")
        }
        return tokenJWT
    }
}

final class NetworkLoginMock: NetworkLoginProtocol {
    func loginUser(user: String, password: String) async throws -> String {
        return UUID().uuidString
    }
}
