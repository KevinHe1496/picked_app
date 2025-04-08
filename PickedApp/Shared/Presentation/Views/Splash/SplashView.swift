//
//  SplashView.swift
//  PickedApp
//
//  Created by Kevin Heredia on 8/4/25.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.primaryColor
                .ignoresSafeArea()
            
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(width: 200)
        }
    }
}

#Preview {
    SplashView()
}
