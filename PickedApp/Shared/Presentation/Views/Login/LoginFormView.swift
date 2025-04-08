//
//  LoginFormView.swift
//  PickedApp
//
//  Created by Kevin Heredia on 8/4/25.
//

import SwiftUI

struct LoginFormView: View {
    @Binding var email: String
    @Binding var pass: String
    
    var body: some View {
        VStack(spacing: 10) {
            TextField("Username", text: $email)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            
            SecureField("Password", text: $pass)
                .textFieldStyle(.roundedBorder)
            
            Button {
                // action here
            } label: {
                Text("Sign in")
                
                    .font(.system(size: 22).bold())
                    .foregroundStyle(.white)
                    .padding(.vertical, 7)
                    .frame(maxWidth: .infinity)
                    .background(.secondaryColor)
            }
            .clipShape(.buttonBorder)
        }
    }
}

#Preview {

    LoginFormView(email: .constant("example@example.com"), pass: .constant("password"))
}
