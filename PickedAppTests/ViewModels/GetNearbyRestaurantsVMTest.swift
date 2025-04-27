//
//  GetNearbyRestaurantsVMTest.swift
//  PickedAppTests
//
//  Created by Kevin Heredia on 26/4/25.
//

import XCTest
@testable import PickedApp

final class GetNearbyRestaurantsVMTest: XCTestCase {
    
    var viewModel: GetNearbyRestaurantViewModel!
    var viewModelFailure: GetNearbyRestaurantViewModel!
    
    override func setUpWithError() throws {
        viewModel = GetNearbyRestaurantViewModel(useCase: GetNearbyRestaurantsUseCaseSuccessMock())
        viewModelFailure = GetNearbyRestaurantViewModel(useCase: GetNearbyRestaurantsUseCaseFailureMock())
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        viewModelFailure = nil
    }
    
    func testGetNearbyRestaurantsSuccessMock() async throws {
       try await viewModel.loadData()
        
        XCTAssertEqual(viewModel.restaurantsNearby.count, 3)
    }
    
    func testGetNearbyRestaurantsFailureMock() async throws {
        do {
           try await viewModelFailure.loadData()
            XCTFail("Expected to fail")
        } catch let error as PKError {
            XCTAssertEqual(error, .badUrl)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
