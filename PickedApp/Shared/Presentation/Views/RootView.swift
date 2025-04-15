//
//  RootView.swift
//  PickedApp
//
//  Created by Kevin Heredia on 14/4/25.
//

import SwiftUI

struct RootView: View {
    @Environment(AppStateVM.self) var appState
    
    var body: some View {
        
        switch appState.status {
        case .none:
            withAnimation {
                SplashView()
            }
        case .loading:
            withAnimation {
                LoadingView()
            }
        case .login:
            withAnimation {
                LoginView()
            }
        case .register:
            withAnimation {
                RegisterView()
            }
        case .loaded:
            withAnimation {
                CustomTabBarView()
            }
        case .error(error: let errorString):
            withAnimation {
                ErrorView(textError: errorString)
            }
        }
    }
}

#Preview {
    RootView()
        .environment(AppStateVM())
}
