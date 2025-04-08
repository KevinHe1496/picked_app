//
//  LoginView.swift
//  PickedApp
//
//  Created by Kevin Heredia on 8/4/25.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var pass = ""
    
    var body: some View {
        NavigationStack {
 
            VStack {
                Image(.logotipo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    
                
                Spacer()
       
                
                Text("Login")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                
                LoginFormView(email: $email, pass: $pass)
                    .padding(.bottom, 100)
  
                
                Spacer()
                
                HStack {
                    Text("New to Picked?")
                        .foregroundStyle(.white)
                    
                    NavigationLink(destination: RegisterView()) {
                        Text("Sign Up here")
                            .foregroundStyle(.black)
                            .underline()
                    }
                }
                .padding(.bottom, 30)
            }
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.primaryColor)
            
        }
    }
}


#Preview {
    LoginView()
}
