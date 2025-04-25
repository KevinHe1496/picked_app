//
//  Crypto.swift
//  PickedApp
//
//  Created by Kevin Heredia on 25/4/25.
//

import Foundation
import CryptoKit


/// Enum to define the size of the key to be used in AES encryption.
/// - bits128: 16 bytes long key.
/// - bits192: 24 bytes long key.
/// - bits256: 32 bytes long key.
enum AESKeySize: Int {
    case bits128 = 16
    case bits192 = 24
    case bits256 = 32
}

public class Crypto {
    // MARK: - Properties
    private let sealedDataBox = "rnYjGPQ9lyITegM6QusUiCaN3KmGcUOT+bIaz2udORD/5Galb+4X/tkP/joDqXAfmf0QxOKlRiE8IMu+ABB3Q7cMeQ+MPdzq"
    private let key: String
    
    // MARK: - Init
    init() {
        let keyData: [UInt8] = [0xBA-0x4F,0x89-0x24,0xDF-0x66,0x21+0x33,0x50+0x1F,0x30+0x15,0x1F+0x4F,0x46+0x1D,0x9A-0x28,0x87-0x0E,0xDC-0x6C,0x97-0x23,0x81-0x3D,0x3C+0x25,0x03+0x71,0x2F+0x32]
        guard let unwrappedKey = String(data: Data(keyData), encoding: .utf8) else {
            print("SSLPinning error: unable to obtain local public key")
            self.key = ""
            return
        }
        self.key = unwrappedKey
    }
    
    // MARK: - Methods
    
    /// Pads a given key to be used in AES encryption with 32 bytes long by default. It uses the PKCS7 standard padding.
    ///  - Parameters:
    ///  - key: The key to be padded.
    ///  - size: The size of the key to be padded. Default is 32 bytes.
    ///  - Returns: The padded key.
    ///
    private func paddedKey_PKCS7(from key: String, withSize size: AESKeySize = .bits256) -> Data {
        // Get the data from the key in Bytes
        guard let keyData = key.data(using: .utf8) else { return Data() }
        // If the key is already the right size, return it
        if(keyData.count == size.rawValue) {return keyData}
        // If the key is bigger, truncate it and return it
        if(keyData.count > size.rawValue) {return keyData.prefix(size.rawValue)}
        // If the key is smaller, pad it
        let paddingSize = size.rawValue - keyData.count % size.rawValue
        let paddingByte: UInt8 = UInt8(paddingSize)
        let padding = Data(repeating: paddingByte, count: paddingSize)
        return keyData + padding
    }
    
    /// Decrypts a given data input using AES algorithm.
    /// Given the symmetric nature of the AES encryption, the key used for encryption has to be used for decryption.
    /// - Parameters:
    /// - input: The data to be decrypted.
    /// - key: The key to be used for decryption. If the key is 32 bytes long, it will be used directly. If the key is shorter than 32 bytes, it will be padded.
    private func decrypt(input: Data, key: String) -> Data {
        do {
            // Get the correct length key
            let keyData = paddedKey_PKCS7(from: key, withSize: .bits128)
            // Get the symmetric key from the key as a string
            let key = SymmetricKey(data: keyData)
            // Get box from the input, if the data is not a box then throw an error
            let box = try AES.GCM.SealedBox(combined: input)
            // Get the plaintext. If any error occurs during the opening process then throw exception
            let opened = try AES.GCM.open(box, using: key)
            // Return the cipher text
            return opened
        } catch {
            return "Error while decryption".data(using: .utf8)!
        }
    }
    
    public func getDecryptedPublicKey () -> String? {
        guard let sealedDataBoxData = Data(base64Encoded: sealedDataBox) else {
            print("Error while decrypting the public key: sealed box is not valid")
            return nil
        }
        let data = decrypt(input: sealedDataBoxData, key: key)
        return String(data: data, encoding: .utf8)
    }
}
