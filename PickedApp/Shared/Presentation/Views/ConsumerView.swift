//
//  ConsumerView.swift
//  PickedApp
//
//  Created by Kevin Heredia on 18/4/25.
//

import SwiftUI

struct ConsumerView: View {
    let restaurants: [Restaurant] = Bundle.main.decode("restaurants.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 180))
    ]
    
    @State private var filterText = ""
    
    var body: some View {
        NavigationStack{
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(restaurants) { restaurant in
                        NavigationLink(value: restaurant) {
                           RestaurantRowView(restaurant: restaurant)
                        }
                    }
                }
            }
            .navigationTitle("Restaurants")
            .searchable(text: $filterText)
        }
    }
}

#Preview {
    ConsumerView()
}
