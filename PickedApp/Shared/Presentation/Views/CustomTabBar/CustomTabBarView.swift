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
            Group{
                ConsumerView()
                    .tabItem {
                        Label("Firsts", systemImage: "1.circle")
                    }
                
                LocationMapView(restaurants: Bundle.main.decode("restaurants.json"))
                    .tabItem {
                        Image(systemName: "map.fill")
                        Text("Map")
                    }
                
                UserProfileView()
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("User")
                    }
            }
            .toolbarBackground(.primaryColor, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
        }
        //            Tab("Home", systemImage: "house.fill") {
        //                ConsumerView()
        //            }
        //
        //            Tab("Map", systemImage: "map.fill") {
        //                LocationMapView(restaurants: Bundle.main.decode("restaurants.json"))
        //            }
        //
        //            Tab("Favorites", systemImage: "star.fill") {
        //                Text("Favorites")
        //            }
        //
        //            Tab("User", systemImage: "person.fill") {
        //                UserProfileView()
        //            }
        
        
    }
        
}

#Preview {
    CustomTabBarView()
}
