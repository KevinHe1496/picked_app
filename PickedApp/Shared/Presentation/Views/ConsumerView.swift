//
//  ConsumerView.swift
//  PickedApp
//
//  Created by Kevin Heredia on 18/4/25.
//

import SwiftUI

struct ConsumerView: View {
    @Environment(AppStateVM.self) var appState
    
    @State var viewModel: AllRestaurantsViewModel
    
    let columns = [
        GridItem(.adaptive(minimum: 180))
    ]
    
    @State private var filterText = ""
    
    init(viewModel: AllRestaurantsViewModel = AllRestaurantsViewModel()) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack{
            ScrollView {
                
                HStack {
                    Text("All")
                    Spacer()
                }
                .padding(.horizontal)
                    
                LazyVGrid(columns: columns) {
                    ForEach(viewModel.restaurantFilter){ restaurant in
                        NavigationLink {
                            RestaurantDetail(restaurantID: restaurant.id)
                        } label: {
                            RestaurantRowView(restaurant: restaurant)
                        }
                    }
                }
            }
            .navigationTitle("Restaurants")
            .searchable(text: $viewModel.search, prompt: "Search")
        }
    }
}

#Preview {
    ConsumerView()
        .environment(AppStateVM())
}
