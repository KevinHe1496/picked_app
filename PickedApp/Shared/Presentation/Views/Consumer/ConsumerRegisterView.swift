import SwiftUI

/// A view that displays a registration form for consumers.
struct ConsumerRegisterView: View {
    
    // MARK: - Properties
    
    @Environment(AppStateVM.self) private var appState
    @State private var viewModel: ConsumerRegisterViewModel
    
    // User input state
    @State var username = ""
    @State var email = ""
    @State var password = ""
    
    // Alert state
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    // MARK: - Initialization
    
    /// Initializes the view with the app state.
    init(appState: AppStateVM) {
        _viewModel = State(initialValue: ConsumerRegisterViewModel(appState: appState))
    }
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            
            // App logo
            Image(.logotipo)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            // Screen title
            Text("Consumer Register")
                .font(.title.bold())
                .foregroundStyle(.white)
            
            VStack(spacing: 10) {
                
                // Username field
                IconTextFieldView(
                    iconName: "person.fill",
                    placeholder: "Username",
                    text: $username,
                    keyboardType: .default
                )
                
                // Email field
                IconTextFieldView(
                    iconName: "envelope.fill",
                    placeholder: "Email",
                    text: $email,
                    keyboardType: .emailAddress
                )
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                
                // Password field
                IconSecureFieldView(
                    icon: "lock.fill",
                    placeholder: "Password",
                    password: $password
                )
                
                // Register button
                CustomButtonView(title: "Register", color: .secondaryColor) {
                    Task {
                        
                        // Validate fields
                        if let error = viewModel.validateFields(name: username, email: email, password: password) {
                            alertMessage = error
                            showAlert = true
                            return
                        }
                        
                        // Proceed with registration
                        await viewModel.consumerRegister(name: username, email: email, password: password, role: "consumer")

                        showAlert = true
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.primaryColor)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Registration"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    ConsumerRegisterView(appState: AppStateVM())
        .environment(AppStateVM())
}
