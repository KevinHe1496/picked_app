//
//  RegisterView.swift
//  PickedApp
//
//  Created by Kevin Heredia on 8/4/25.
//

import SwiftUI

struct RegisterView: View {
    var body: some View {
        ZStack {
            Color.primaryColor
                .ignoresSafeArea()
            
            VStack {
                Image(.logotipo)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                
                Text("Are you a restaurant owner or a consumer?")
                    .foregroundStyle(.white)
                    .font(.headline)
                
                HStack{
                    
                    Button {
                        // action here
                    } label: {
                        Text("Restaurant")
                            .font(.system(size: 22).bold())
                            .foregroundStyle(.white)
                            .frame(maxWidth: 200)
                            .padding(.vertical, 7)
                            .background(.secondaryColor)
                            .clipShape(.buttonBorder)
                    }
                    
                    Button {
                        // action here
                    } label: {
                        Text("Consumer")
                            .font(.system(size: 22).bold())
                            .foregroundStyle(.white)
                            .frame(maxWidth: 200)
                            .padding(.vertical, 7)
                            .background(.secondaryColor)
                            .clipShape(.buttonBorder)
                    }
                }
                .padding()
                
                
            }
        }
    }
}

#Preview {
    RegisterView()
}
