//
//  GetAllRestaurantsUsecaseTest.swift
//  PickedAppTests
//
//  Created by Kevin Heredia on 24/4/25.
//

import XCTest
@testable import PickedApp

final class GetAllRestaurantsUsecaseTest: XCTestCase {
    
    var useCase: AllRestaurantsUseCase!
    var useCaseFailure: AllRestaurantsUseCase!

    override func setUpWithError() throws {
        useCase = AllRestaurantsUseCase(repo: DefaultAllRestaurantsRepositorySuccessMock())
        useCaseFailure = AllRestaurantsUseCase(repo: DefaultAllRestaurantsRepositoryFailureMock())
    }

    override func tearDownWithError() throws {
        useCase = nil
        useCaseFailure = nil
    }
    
    func testGetAllRestaurantsSuccess() async throws {
        let restaurants = try await useCase.getRestaurants()
        XCTAssertEqual(restaurants.count, 3)
    }
    
    func testGetAllRestaurantsFailure() async throws {
        do {
            let _ = try await useCaseFailure.getRestaurants()
            XCTFail("expected to fail")
        } catch let error as PKError {
            XCTAssertEqual(error, .badUrl)
        } catch {
            XCTFail()
        }
    }
}
