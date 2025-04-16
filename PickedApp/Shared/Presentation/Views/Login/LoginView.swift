//
//  LoginView.swift
//  PickedApp
//
//  Created by Kevin Heredia on 8/4/25.
//

import SwiftUI

/// A login screen where users can enter their email and password to access the app.
/// Also provides a link to register if the user is new.
struct LoginView: View {
    @Environment(AppStateVM.self) var appState
    
    // MARK: - State Properties
    @State private var email = "kevin@example.com"
    @State private var password = "123456"
    
    // MARK: - Alert state
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                
                // MARK: - Logo Section
                VStack {
                    Image(.logotipo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .ignoresSafeArea(.keyboard)
                
                // MARK: - Login Form Section
                VStack(spacing: 10) {
                    
                    Text("Login")
                        .font(.title.bold())
                        .foregroundStyle(.white)
                    
                    // Email input field
                    IconTextFieldView(
                        iconName: "person.fill",
                        placeholder: "Username",
                        text: $email,
                        keyboardType: .default
                    )
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    
                    // Password input field
                    IconSecureFieldView(
                        icon: "lock.fill",
                        placeholder: "Password",
                        password: $password
                    )
                    
                    // Login button
                    CustomButtonView(title: "Login", color: .secondaryColor) {
                        // TODO: Handle login action
                        Task {
                            if let error = await appState.loginUser(user: email, pass: password) {
                                alertMessage = error
                                showAlert = true
                            }
                        }
                    }

                }
                .frame(maxHeight: .infinity, alignment: .center)
                
                // MARK: - Sign Up Section
                HStack {
                    Text("New to Picked?")
                        .foregroundStyle(.white)
                    
                    // Navigation to registration view
                    NavigationLink(destination: RegisterView()) {
                        Text("Sign Up here")
                            .foregroundStyle(.black)
                            .underline()
                    }
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, 30)
                .ignoresSafeArea(.keyboard)
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.primaryColor)
            .alert("Login", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
        }
    }
}

#Preview {
    LoginView()
        .environment(AppStateVM())
}
