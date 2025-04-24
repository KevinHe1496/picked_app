//
//  GetAllRestaurantsVMTest.swift
//  PickedAppTests
//
//  Created by Kevin Heredia on 23/4/25.
//

import XCTest
@testable import PickedApp

final class GetAllRestaurantsVMTest: XCTestCase {
    
    var viewModel: AllRestaurantsViewModel!
    var viewModelFailure: AllRestaurantsViewModel!

    override func setUpWithError() throws {
        viewModel = AllRestaurantsViewModel(useCase: AllRestaurantsUseCaseSuccessMock())
        viewModelFailure = AllRestaurantsViewModel(useCase: AllRestaurantsUseCaseFailureMock())
    }

    override func tearDownWithError() throws {
        viewModel = nil
        viewModelFailure = nil
    }
    
    func testGetAllRestaurantsSuccessMock() async throws {
        // given
      let _ = try await viewModel.getRestaurants()
        
        XCTAssertEqual(viewModel.restaurantsData.count, 3)
    }
    
    func testGetAllRestaurantsFailureMock() async throws {
        
        do {
            let _ = try await viewModelFailure.getRestaurants()
           XCTFail("expected to fail")
        } catch let error as PKError {
            XCTAssertEqual(error, .badUrl)
        } catch {
            XCTFail()
        }
    }

}
