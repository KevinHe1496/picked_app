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
                    .frame(maxWidth: .infinity, alignment: .center)
           
            
            
            VStack(spacing: 10) {
                TextField("Username", text: $username)
                    .textFieldStyle(.roundedBorder)
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                SecureField("Password", text: $password)
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
                        .clipShape(.buttonBorder)
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
