//
//  NetworkGetAllRestaurantsTest.swift
//  PickedAppTests
//
//  Created by Kevin Heredia on 23/4/25.
//

import XCTest
@testable import PickedApp

final class NetworkGetAllRestaurantsTest: XCTestCase {
    
    var network: NetworkAllRestaurants!
    
    override func setUpWithError() throws {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [URLProtocolMock.self]
        let session = URLSession(configuration: config)
        
        network = NetworkAllRestaurants(session: session)
    }
    
    override func tearDownWithError() throws {
        network = nil
        URLProtocolMock.statusCode = 200
        URLProtocolMock.stubResponseData = nil
        URLProtocolMock.error = nil
    }
    
    
    func testNetowkAllRestaurants_GivenASuccesfullJson_ShouldSuccess() async throws {
        
        let data = try MockData.loadJSONData(name: "GetAllRestaurantsMock")
        URLProtocolMock.stubResponseData = data
        
        do {
            let restaurants = try await network.getRestaurants()
            XCTAssertEqual(restaurants.count, 15)
            XCTAssertEqual(restaurants[0].name, "Casa Paco")
        } catch {
            XCTFail()
        }
    }
    
    
    func testNetworkAllRestaurants_GivenABadJson_ShouldFailure() async throws {
        let data = "{}".data(using: .utf8)
        URLProtocolMock.stubResponseData = data
        URLProtocolMock.statusCode = 500
        
        do {
             _ = try await network.getRestaurants()
            XCTFail("We Expect failure")
        } catch let error as PKError {
            XCTAssertEqual(error, .errorFromApi(statusCode: 500))
        
        } catch {
            XCTFail()
        }
    }
    
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
