//
//  RestaurantRegisterVMTest.swift
//  PickedAppTests
//
//  Created by Kevin Heredia on 23/4/25.
//

import XCTest
import CoreLocation
@testable import PickedApp

final class RestaurantRegisterVMTest: XCTestCase {
    
    func testRestaurantRegisterSuccess() async throws {
        
        //Given
        let mockUseCase = RestaurantRegisterUseCaseMock()
        let mockAppState = AppStateVM()
        let viewModel = RestaurantResgisterViewModel(useCase: mockUseCase, appState: mockAppState)
        
        // When
        let error = try await viewModel.restaurantRegister(
            email: "test@example.com",
            password: "test",
            role: "restaurant",
            restaurantName: "test",
            info: "test",
            address: "test",
            country: "test",
            city: "test",
            zipCode: "test",
            name: "test",
            photo: Data()
        )
        // Then
        XCTAssertNil(error)
        XCTAssertEqual(mockAppState.status, .restaurantMeals)
        XCTAssertEqual(viewModel.latitude, 37.91149732310269)
        XCTAssertEqual(viewModel.longitude, -121.31035538536838)
        XCTAssertFalse(viewModel.isLoading)
        
    }

    func testRegisterRestaurantFailure() async throws {
        // given
        let mockUseCase = RestaurantRegisterUseCaseFailureMock()
        let mockAppState = AppStateVM()
        let viewModel = RestaurantResgisterViewModel(useCase: mockUseCase, appState: mockAppState)
        
        // when
        let error = try await viewModel.restaurantRegister(
            email: "test@example.com",
            password: "test",
            role: "restaurant",
            restaurantName: "test",
            info: "test",
            address: "test",
            country: "test",
            city: "test",
            zipCode: "test",
            name: "test",
            photo: Data()
        )
        // then
        XCTAssertEqual(error, "Incorrect")
        XCTAssertEqual(mockAppState.status, .error(error: "Incorrect form"))
        XCTAssertFalse(viewModel.isLoading)
    }
}
