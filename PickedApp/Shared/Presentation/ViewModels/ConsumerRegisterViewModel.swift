//
//  ConsumerRegisterViewModel.swift
//  PickedApp
//
//  Created by Kevin Heredia on 15/4/25.
//

import Foundation

/// ViewModel for managing consumer registration.
@Observable
final class ConsumerRegisterViewModel {
    
    // MARK: - Properties
    
    private var appState: AppStateVM
    var isloading: Bool = false
    var isRegistered: Bool = false
    var errorMessage: String?
    
    @ObservationIgnored
    private let useCase: ConsumerRegisterUseCaseProtocol
    
    // MARK: - Initialization
    
    /// Initializes the view model with the use case and app state.
    init(useCase: ConsumerRegisterUseCaseProtocol = ConsumerRegisterUseCase(), appState: AppStateVM) {
        self.useCase = useCase
        self.appState = appState
    }
    
    // MARK: - Methods
    
    /// Registers a consumer asynchronously, updating app state based on success or failure.
    @MainActor
    func consumerRegister(name: String, email: String, password: String, role: String) async {
        isloading = true
        errorMessage = nil
        appState.status = .loading

        do {
            let result = try await useCase.consumerRegisterUser(name: name, email: email, password: password, role: role)
            appState.status = result ? .login : .error(error: "Incorrect username or password.")
        } catch {
            appState.status = .error(error: "Something went wrong.")
            errorMessage = error.localizedDescription
        }

        isloading = false
    }
    
    // MARK: - Validation
    
    /// Validates the input fields for registration.
    /// - Returns: An error message if validation fails, otherwise nil.
    func validateFields(name: String, email: String, password: String) -> String? {
        if name.isEmpty || email.isEmpty || password.isEmpty {
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
