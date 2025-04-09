import SwiftUI

struct ConsumerRegisterView: View {
    
    @State var username = ""
    @State var email = ""
    @State var password = ""
    
    var body: some View {
        VStack {
                
                Image(.logotipo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Text("Consumer Register")
                    .font(.title.bold())
                    .foregroundStyle(.white)
           
            VStack(spacing: 10) {
                
                IconTextFieldView(iconName: "person.fill", placeholder: "Username", text: $username, keyboardType: .default)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                
                IconTextFieldView(iconName: "envelope.fill", placeholder: "Email", text: $email, keyboardType: .emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                
                IconSecureFieldView(icon: "lock.fill", placeholder: "Password", password: $password)
                
                CustomButtonView(title: "Register", color: .secondaryColor) {
                    // action here
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
//        .preferredColorScheme(.dark)
}
