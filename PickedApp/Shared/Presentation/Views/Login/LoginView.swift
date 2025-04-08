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
                VStack {
                    Image(.logotipo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250, height: 250)
                }
                .frame(maxHeight: .infinity, alignment: .top)

                LoginFormView(email: $email, pass: $password)
                    .frame(maxHeight: .infinity, alignment: .center)
  
                
                
                
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
