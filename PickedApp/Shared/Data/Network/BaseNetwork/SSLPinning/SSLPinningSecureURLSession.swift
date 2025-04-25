//
//  SSLPinningSecureURLSession.swift
//  PickedApp
//
//  Created by Kevin Heredia on 24/4/25.
//

import Foundation

class SSLPinningSecureURLSession {
    // MARK: - Variables
    let session: URLSession
    
    //MARK: - Initializers
    init() {
        session = URLSession(
            configuration: .ephemeral,
            delegate: SSLPinningDelegate(),
            delegateQueue: nil
        )
    }
}

//MARK: - URLSession extension: shared
extension URLSession {
    static var shared: URLSession {
        return SSLPinningSecureURLSession().session
    }
}
