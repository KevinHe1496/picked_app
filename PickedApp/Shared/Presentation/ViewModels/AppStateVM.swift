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
    func loginUser(user: String, pass: String) {
        loginError = nil
        
        guard isValidEmailPassword(user, pass) else {
            loginError = "Invalid email or password."
            return
        }
        
        self.status = .loading
        
        Task {
            if try await loginUseCase.loginUser(user: user, password: pass) == true {
                self.status = .loaded
            } else {
                self.status = .error(error: "Incorrect username or password")
            }
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
    
    /// Validates the format of email and password input
    private func isValidEmailPassword(_ email: String, _ password: String) -> Bool {
        return email.contains("@") && email.contains(".") && password.count > 5 && !password.isEmpty
    }
}
