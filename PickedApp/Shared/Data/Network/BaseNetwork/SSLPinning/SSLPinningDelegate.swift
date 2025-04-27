//
//  SSLPinningDelegate.swift
//  PickedApp
//
//  Created by Kevin Heredia on 24/4/25.
//

import Foundation
import CommonCrypto
import CryptoKit

class SSLPinningDelegate: NSObject {
    
    //MARK: - Properties
    private let crypto: Crypto
    
    //MARK: Init
    override init() {
        self.crypto = Crypto()
    }
    

}

extension SSLPinningDelegate: URLSessionDelegate {
    
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        // Get the server trust
        guard let serverTrust = challenge.protectionSpace.serverTrust else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            print("SSLPining error: server didn't trust")
            return
        }
        
        // Get the server certificates: if the trust of the server contains a certificate array at identifies the server
        let serverCertificates: [SecCertificate]?
        serverCertificates = SecTrustCopyCertificateChain(serverTrust) as? [SecCertificate]
        // Unwrap server certificate, if not available, then SSLPinning error
        guard let serverCertificate = serverCertificates?.first else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            print("SSLPinning error: server certificate is nil")
            return
        }
        
        // Get the server public key: the certificate contains the public key of the server
        guard let serverPublicKey = SecCertificateCopyKey(serverCertificate) else {
            completionHandler(.cancelAuthenticationChallenge, nil)
            print("SSLPinning error: server public key is nil")
            return
        }
        // Transform the public key to data (currently is a SecKey)
        guard let serverPublicKeyRep = SecKeyCopyExternalRepresentation(serverPublicKey, nil) else {
            print("SSLPinning error: unable to convert server public key to data")
            completionHandler(.cancelAuthenticationChallenge, nil)
            return
        }
        let serverPublicKeyData: Data = serverPublicKeyRep as Data
        
        // Sha 256 server public key in base64
        let serverHashKeyBase64 = sha256CryptoKit(data: serverPublicKeyData)
        
        // Print public keys
        print("Decrypted key is \(String(describing: Crypto().getDecryptedPublicKey()))")
        print("Server key is \(serverHashKeyBase64)")
        
        // Decrypt public key
        let crypto = Crypto()
        
        // Check server key is the same as local key
        if serverHashKeyBase64 == crypto.getDecryptedPublicKey() {
            // Success -> the server key is the expected key. Complete the process and send the credentials
            completionHandler(.useCredential, URLCredential(trust: serverTrust))
            print("SSLPinning filter passed")
        } else{
            // Error -> the server key differs from the expected key. Cancel the process
            print("SSLPinning error: server certificate doesn't match")
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
}


//MARK: - SSLPinning extension: SHA
extension SSLPinningDelegate{
    
    /// Create a SHA256 representation of the data passed as parameter (common crypto)
    /// - Parameter data: The data that will be converted to SHA256.
    /// - Returns: The SHA256 representation of data.
    private func sha256(data : Data) -> String{
        
        // Get the data of the sha256 in a variable
        let dataToHash = Data(data)
        
        // Create a byte array to which the data will be copied
        var hash = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        
        // Copy the data to the hash byte array (Common crypto, not cryptoKit)
        dataToHash.withUnsafeBytes { bufferPointer in
            _ = CC_SHA256(bufferPointer.baseAddress, CC_LONG(bufferPointer.count), &hash)
        }
        
        // Convert hash to a base 64 string
        return Data(hash).base64EncodedString()
    }
    
    /// Create a SHA256 representation of the data passed as parameter (crypto kit)
    /// - Parameter data: The data that will be converted to SHA256.
    /// - Returns: The SHA256 representation of data.
    private func sha256CryptoKit(data: Data) -> String {
        let hash = SHA256.hash(data: data)
        return Data(hash).base64EncodedString()
    }
}
