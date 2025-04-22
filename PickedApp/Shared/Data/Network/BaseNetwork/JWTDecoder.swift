//
//  JWTDecoder.swift
//  PickedApp
//
//  Created by Jorge Navidad Espliego on 22/4/25.
//


import Foundation

//MARK: Método para decodificar el rol del usuario
struct JWTDecoder {
    static func decodeRole(from token: String) -> String? {
        let segments = token.split(separator: ".")
        guard segments.count > 1 else { return nil }

        let payloadSegment = segments[1]
        var base64String = String(payloadSegment)
        base64String = base64String.padding(toLength: ((base64String.count+3)/4)*4,
                                            withPad: "=",
                                            startingAt: 0)
        guard let data = Data(base64Encoded: base64String),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let role = json["role"] as? String else {
            return nil
        }

        return role
    }
}
