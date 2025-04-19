//
//  RestaurantOwnerView.swift
//  PickedApp
//
//  Created by Kevin Heredia on 18/4/25.
//

import SwiftUI

struct RestaurantOwnerView: View {
    @State private var textFilter = ""
    var body: some View {
        NavigationStack {
            ScrollView {
                
                Text("hola")
                
            }
            .searchable(text: $textFilter)
            .navigationTitle("Restaurants")
        }
    }
}

#Preview {
    RestaurantOwnerView()
}
