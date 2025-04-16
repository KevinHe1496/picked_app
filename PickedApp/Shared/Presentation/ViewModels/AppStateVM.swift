//
//  AppStateVM.swift
//  PickedApp
//
//  Created by Kevin Heredia on 14/4/25.
//

import Foundation
import Combine

/// ViewModel that manages the app's global authentication state.
@Observable
final class AppStateVM {
    
    // MARK: - Properties
    
    var status = Status.none // Current app state (loading, login, etc.)
    var tokenJWT: String = "" // Auth token
    var loginError: String? // Login error message
    
    @ObservationIgnored
    private var loginUseCase: LoginUseCaseProtocol
    @ObservationIgnored
    var isLogged: Bool = false // Indicates if the user is logged in

    // MARK: - Init
    
    /// Creates the view model and validates login status on launch.
    init(loginUseCase: LoginUseCaseProtocol = LoginUseCase()) {
        self.loginUseCase = loginUseCase
        
        Task {
            await validateControlLogin()
        }
    }
    
    // MARK: - Methods
    
    /// Logs in the user and updates the app state.
    @MainActor
    func loginUser(user: String, pass: String) async -> String? {
        loginError = nil
        
        if let validationError = isValidEmailPassword(user, pass) {
            return validationError
        }
        
        self.status = .loading
        
        do {
            let success = try await loginUseCase.loginUser(user: user, password: pass)
            if success {
                self.status = .loaded
                return nil
            } else {
                self.status = .error(error: "Incorrect username or password")
                return "Incorrect username or password"
            }
        } catch {
            self.status = .error(error: "An error occurred during login.")
            return "An error occurred during login."
        }
    }

    /// Logs out the user and resets the state.
    @MainActor
    func closeSessionUser() {
        Task {
            await loginUseCase.logout()
            self.status = .login
        }
    }

    /// Validates if the user is already logged in using a stored token.
    @MainActor
    func validateControlLogin() {
        Task {
            if await loginUseCase.validateToken() == true {
                self.status = .loaded
                NSLog("Login ok")
            } else {
                self.startSplashToLoginView()
            }
        }
    }

    // MARK: - Navigation Helpers
    
    /// Shows splash screen and then navigates to login view.
    func startSplashToLoginView() {
        self.status = .none
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            Task { @MainActor in
                self.status = .login
            }
        }
    }

    // MARK: - Validation
    
    /// Validates email and password fields.
    func isValidEmailPassword(_ email: String, _ password: String) -> String? {
        if email.isEmpty || password.isEmpty {
            return "All fields are required."
        }
        if !email.contains("@") || !email.contains(".") {
            return "Invalid email or password."
        }
        if password.count < 6 {
            return "Invalid email or password."
        }
        return nil
    }
}
