//
//  AppStateVM.swift
//  PickedApp
//
//  Created by Kevin Heredia on 14/4/25.
//

import Foundation
import Combine

@Observable
final class AppStateVM {
    var status = Status.none
    var tokenJWT: String = ""
    var loginError: String?
    
    @ObservationIgnored
    private var loginUseCase: LoginUseCaseProtocol
    @ObservationIgnored
    var isLogged: Bool = false
    
    
    
    init(loginUseCase: LoginUseCaseProtocol = LoginUseCase()) {
        self.loginUseCase = loginUseCase
        
        Task {
            await validateControlLogin()
        }
    }
    
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
    
    @MainActor
    func closeSessionUser() {
        Task {
            await loginUseCase.logout()
            self.status = .login
        }
    }
    
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
    
    /// Navigates from splash screen to login view after a short delay
    func startSplashToLoginView() {
        self.status = .none
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            Task { @MainActor in
                self.status = .login
            }
        }
    }
    
    // MARK: - Validation
    
    /// Validates the input fields for registration.
    /// - Returns: An error message if validation fails, otherwise nil.
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
