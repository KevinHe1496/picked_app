//
//  TabBarStyleHelper.swift
//  PickedApp
//
//  Created by Kevin Heredia on 16/4/25.
//

import SwiftUI

struct TabBarStyleHelper {
    static func applyCustomAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.primaryColor)
        
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.white
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color.secondaryColor)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor(Color.secondaryColor)
        ]
        
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
