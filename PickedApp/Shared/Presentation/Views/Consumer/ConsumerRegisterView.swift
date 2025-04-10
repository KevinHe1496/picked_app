import SwiftUI

/// A view that displays a registration form for consumers.
struct ConsumerRegisterView: View {
    
    // MARK: - User Input State
    @State var username = ""
    @State var email = ""
    @State var password = ""
    
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
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                
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
                    // Handle registration logic here
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.primaryColor)
    }
}

#Preview {
    ConsumerRegisterView()
}
