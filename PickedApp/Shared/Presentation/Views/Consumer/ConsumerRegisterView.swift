//
//  ConsumerRegisterView.swift
//  PickedApp
//
//  Created by Kevin Heredia on 8/4/25.
//

import SwiftUI

struct ConsumerRegisterView: View {
    
    @State var username = ""
    @State var email = ""
    @State var pass = ""
    
    var body: some View {
        
        NavigationStack {
            VStack(spacing: 20) {
                Image(.logotipo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                
                Text("Consumer Register")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
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
                    // action here
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
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.primaryColor)
        }
        
        
    }
}

#Preview {
    ConsumerRegisterView()
}
