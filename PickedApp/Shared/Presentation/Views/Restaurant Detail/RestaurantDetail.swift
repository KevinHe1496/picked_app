//
//  RestaurantDetail.swift
//  PickedApp
//
//  Created by Kevin Heredia on 21/4/25.
//

import SwiftUI

struct RestaurantDetail: View {
    
    var restaurantID: String
    
    @State private var viewModel: RestaurantDetailViewModel
    
    init(restaurantID: String, viewModel: RestaurantDetailViewModel = RestaurantDetailViewModel()) {
        self.restaurantID = restaurantID
        self.viewModel = viewModel
    }

    var body: some View {
        Text(viewModel.restaurantData.name)
            .onAppear {
                Task {
                   try await viewModel.getRestaurantDetail(restaurantId: restaurantID)
                }
            }
    }
}

#Preview {
    RestaurantDetail(restaurantID: "")
}

