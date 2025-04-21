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
                ConsumerView()
            }
            
            Tab("Map", systemImage: "map.fill") {
                LocationMapView()
                
            }
            
            Tab("User", systemImage: "person.fill") {
                UserProfileView()
            }
        }
        .toolbarBackground(.primaryColor, for: .tabBar)
        .toolbarBackground(.visible, for: .tabBar)
        
    }
}



#Preview {
    CustomTabBarView()
}
