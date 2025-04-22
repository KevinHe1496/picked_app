//
//  UserProfileView.swift
//  PickedApp
//
//  Created by Kevin Heredia on 14/4/25.
//

import SwiftUI

struct UserProfileView: View {
    @Environment(AppStateVM.self) var appState
    var body: some View {
        
        Button("Log out") {
            appState.closeSessionUser()
        }
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    UserProfileView()
        .environment(AppStateVM())
}
