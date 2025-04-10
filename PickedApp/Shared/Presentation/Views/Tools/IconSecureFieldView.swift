//
//  IconSecureTextView.swift
//  PickedApp
//
//  Created by Kevin Heredia on 9/4/25.
//

import SwiftUI

struct IconSecureFieldView: View {
    let icon: String
    let placeholder: String
    @Binding var password: String
    
    var body: some View {
        
        //MARK: Custom SecureField 
        HStack {
            Image(systemName: icon)
                .foregroundStyle(.secondaryColor)
            SecureField(placeholder, text: $password)
                .padding(.vertical, 7)
        }
        .padding(.horizontal)
        .background(Color(.systemBackground))
        .clipShape(.buttonBorder)
    }
}

#Preview {
    IconSecureFieldView(icon: "lock.fill", placeholder: "Password", password: .constant("123456"))
        .preferredColorScheme(.dark)
}
