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
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
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
