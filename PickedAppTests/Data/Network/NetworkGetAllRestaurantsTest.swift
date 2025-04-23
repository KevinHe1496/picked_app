//
//  NetworkGetAllRestaurantsTest.swift
//  PickedAppTests
//
//  Created by Kevin Heredia on 23/4/25.
//

import XCTest
@testable import PickedApp

final class NetworkGetAllRestaurantsTest: XCTestCase {

    func testGetAllRestaurantsSuccess() async throws {
        // Arrange
        let mock = NetworkAllRestaurantsSuccessMock()
        
        // Act
        let result = try await mock.getRestaurants()
        
        // Assert
        XCTAssertEqual(result.count, 3, "Debería devolver 3 restaurantes de prueba.")
        
    }
    
    func test_getRestaurants_failure_shouldThrowError() async {
        // Arrange
        let network = NetworkAllRestaurantsFailureMock()
        
        // Act & Assert
        do {
            let _ = try await network.getRestaurants()
            XCTFail("Se esperaba que se lanzara un error, pero no se lanzó ninguno.")
        } catch {
            // Comprobamos que el error es del tipo esperado (sin comparar igualdad exacta)
            XCTAssertTrue(error is PKError, "El error lanzado no es del tipo PKError")
        }
    }

}
