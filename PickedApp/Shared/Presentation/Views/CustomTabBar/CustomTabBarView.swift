//
//  CustomTabBarView.swift
//  PickedApp
//
//  Created by Kevin Heredia on 14/4/25.
//

import SwiftUI

struct CustomTabBarView: View {
    
    init() {
        // Create a custom appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        // Use your custom color as the background
        appearance.backgroundColor = UIColor(Color.primaryColor)
        
        // Selected icon and text: mainBrownColor
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.white)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(Color.white)
        ]
        
        // Unselected icon and text: white
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color.secondaryColor)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor(Color.secondaryColor)
        ]
        
        // Apply appearance to the TabBar
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
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
                Text("User")
            }
            
        }
    }
}

#Preview {
    CustomTabBarView()
}
