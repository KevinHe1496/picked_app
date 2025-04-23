//
//  AppStateVMTest.swift
//  PickedAppTests
//
//  Created by Kevin Heredia on 15/4/25.
//

import XCTest
@testable import PickedApp

/// Tests for the `AppStateVM` view model, validating login flow, logout behavior, and status management.
final class AppStateVMTest: XCTestCase {
    
    // MARK: - Login Tests
    
    /// Tests that the login flow with correct credentials sets the status to `.loaded`.
    func testLoginUserSuccess() async {
        // Given
        let expectation = XCTestExpectation(description: "Login should complete and set status to .loaded")
        let sut = AppStateVM(loginUseCase: LoginUseCaseSucessMock())
        
        // When
        Task {
          _ = await sut.loginUser(user: "test@example.com", pass: "123456")
            try? await Task.sleep(nanoseconds: 300_000_000) // Allow async process to complete
            
            // Then
            XCTAssertEqual(sut.status, .loaded)
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 1)
    }
    
    /// Tests that login with incorrect credentials sets the status to `.error`.
    func testLoginUserFailure() async {
        // Given
        let expectation = XCTestExpectation(description: "Login should fail and set status to .error")
        let sut = AppStateVM(loginUseCase: LoginUseCaseFailureMock())
        
        // When
        Task {
            
            let errorMessage = await sut.loginUser(user: "test@example.com", pass: "example")
            _ = await sut.loginUser(user: "test@example.com", pass: "wrongPassword")
            try? await Task.sleep(nanoseconds: 300_000_000)
            
            // Then
            XCTAssertEqual(sut.status, .error(error: "An error occurred during login."))
            XCTAssertEqual(errorMessage, "An error occurred during login.")
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 1)
    }
    
    /// Tests that login with invalid credentials does not proceed and shows validation error.
    func testLoginWithInvalidCretendials_shouldNotStartLogin() async {
        // Given
        let vm = AppStateVM(loginUseCase: LoginUseCaseSucessMock())
        
        // When
        let validationError = await vm.loginUser(user: "invalidemail", pass: "123")
        
        // Then
        XCTAssertEqual(validationError, "Invalid email or password.")
        XCTAssertEqual(vm.status, .none)
    }
    
    /// Tests that login with valid credentials sets status to `.loaded`.
    func testLogin_withValidCredentials_shouldSetStatusToLoaded() async {
        // Given
        let expectation = XCTestExpectation(description: "Valid credentials should set status to .loaded")
        let vm = AppStateVM(loginUseCase: LoginUseCaseSucessMock())
        
        // When
        Task {
            _ = await vm.loginUser(user: "example@example.com", pass: "123456")
            try? await Task.sleep(nanoseconds: 300_000_000)
            
            // Then
            XCTAssertEqual(vm.status, .loaded)
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 1)
    }
    
    // MARK: - Logout Tests
    
    /// Tests that calling logout resets the status to `.login`.
    func testLogout_shouldSetStatusToLogin() async {
        // Given
        let expectation = XCTestExpectation(description: "Session should return to .login")
        let vm = AppStateVM(loginUseCase: LoginUseCaseSucessMock())
        
        // When
        Task {
            await vm.closeSessionUser()
            try? await Task.sleep(nanoseconds: 300_000_000)
            
            // Then
            XCTAssertEqual(vm.status, .login)
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 1)
    }
    
    // MARK: - Token Validation
    
    /// Tests that when there is no valid token, the status transitions to `.none` or `.login`.
    func testValidateToken_whenInvalid_shouldSetStatusLoginAfterSplash() async {
        // Given
        let vm = AppStateVM(loginUseCase: LoginUseCaseSucessMock())
        
        // When
        await vm.validateControlLogin()
        
        // Then
        XCTAssertTrue([.none, .login].contains(vm.status))
    }
}
