//
//  CustomTabBarView.swift
//  PickedApp
//
//  Created by Kevin Heredia on 14/4/25.
//

import SwiftUI

struct CustomTabBarView: View {
    
    init() {
        TabBarStyleHelper.applyCustomAppearance()
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
                UserProfileView()
            }
            
        }
    }
}

#Preview {
    CustomTabBarView()
}
