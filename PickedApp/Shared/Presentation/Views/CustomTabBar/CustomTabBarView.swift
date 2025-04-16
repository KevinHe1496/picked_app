//
//  CustomTabBarView.swift
//  PickedApp
//
//  Created by Kevin Heredia on 14/4/25.
//

import SwiftUI

struct CustomTabBarView: View {
        
    var body: some View {
        TabView {
            
            Tab("Home", systemImage: "house.fill") {
                Text("Home")
            }
            
            Tab("Map", systemImage: "map.fill") {
                LocationMapView()
            }
            
            Tab("Favorites", systemImage: "star.fill") {
                Text("Favorites")
            }
            
            Tab("User", systemImage: "person.fill") {
                UserProfileView()
            }
            
        }
        .onAppear {
                let appearance = UITabBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = UIColor(Color.primaryColor)

                appearance.stackedLayoutAppearance.selected.iconColor = UIColor.white
                appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.white]

                appearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color.secondaryColor)
                appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(Color.secondaryColor)]

                UITabBar.appearance().standardAppearance = appearance
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
    }
}

#Preview {
    CustomTabBarView()
}
