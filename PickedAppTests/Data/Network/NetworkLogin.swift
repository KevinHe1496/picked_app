//
//  NetworkLogin.swift
//  PickedAppTests
//
//  Created by Kevin Heredia on 15/4/25.
//

import XCTest
@testable import PickedApp

final class NetworkLogin: XCTestCase {
    
    var sut: NetworkLoginProtocol!  // System Under Test (SUT)

    override func setUpWithError() throws {
        sut = NetworkLoginMock()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    // MARK: - Success
    func testNetworkLogin_WhenUserLogin_ShouldReturnToken() async throws {
        
        // Given
        let email = "test@example.com"
        let password = "example"

        // When
        let token = try await sut.loginUser(user: email, password: password)
        
        // Then
        XCTAssertFalse(token.isEmpty, "The token shouldn't be empty")
    }
    
    // MARK: - Error
    func testNetworkLogin_ThrowsError() async throws {
        // Given
        let sut: NetworkLoginProtocol = NetworkLoginErrorMock()
        
        // When & Then
        do {
            _ = try await sut.loginUser(user: "badUser", password: "wrongPass")
            XCTFail("This expected an error")
        } catch {
            XCTAssertTrue(error is PKError, "The error should be a PKError")
        }
        
    }

}
