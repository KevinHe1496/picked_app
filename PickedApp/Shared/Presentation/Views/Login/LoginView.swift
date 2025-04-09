//
//  LoginView.swift
//  PickedApp
//
//  Created by Kevin Heredia on 8/4/25.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    
    var body: some View {
        NavigationStack {
 
            VStack {
                
                //Logo Section
                VStack {
                    Image(.logotipo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                
                //Login Form Section
                VStack(spacing: 10) {
                    
                    Text("Login")
                        .font(.title.bold())
                        .foregroundStyle(.white)
                    
                    IconTextFieldView(iconName: "person.fill", placeholder: "Username", text: $email, keyboardType: .default)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)

                    IconSecureFieldView(icon: "lock.fill", placeholder: "Password", password: $password)
                    
                    CustomButtonView(title: "Login", color: .secondaryColor) {
                        // action here
                        print(email)
                        print(password)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .center)
                
                
                // Sign up Section
                HStack {
                    Text("New to Picked?")
                        .foregroundStyle(.white)
                    
                    NavigationLink(destination: RegisterView()) {
                        Text("Sign Up here")
                            .foregroundStyle(.black)
                            .underline()
                    }
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, 30)
            }
            
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.primaryColor)
            
        }
    }
}


#Preview {
    LoginView()
        
}
