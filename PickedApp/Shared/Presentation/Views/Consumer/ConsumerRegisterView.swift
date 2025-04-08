import SwiftUI

struct ConsumerRegisterView: View {
    
    @State var username = ""
    @State var email = ""
    @State var pass = ""
    
    var body: some View {
        VStack {
            Section {
                
                Image(.logotipo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Text("Consumer Register")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            
            
            Section {
                TextField("Username", text: $username)
                    .textFieldStyle(.roundedBorder)
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                SecureField("Password", text: $pass)
                    .textFieldStyle(.roundedBorder)
                
                Button {
                    // acción de registro
                } label: {
                    Text("Register")
                        .font(.system(size: 22).bold())
                        .foregroundStyle(.white)
                        .padding(.vertical, 7)
                        .frame(maxWidth: .infinity)
                        .background(.secondaryColor)
                }
                .clipShape(.buttonBorder)
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
