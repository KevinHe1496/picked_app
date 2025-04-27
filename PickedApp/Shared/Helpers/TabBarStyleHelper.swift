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
        // Configurar el color de fondo de la barra de pestañas
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.primaryColor)
        // Configurar el color del ícono y texto para el estado no seleccionado
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor.white
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
        // Configurar el color del ícono y texto para el estado seleccionado
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color.secondaryColor)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor(Color.secondaryColor)
        ]
        // Aplicar la apariencia a la barra de pestañas
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
        
        // Para iOS 15 y versiones posteriores
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = appearance
        }
    }
}
