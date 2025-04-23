//
//  NetworkRestaurantRegisterTest.swift
//  PickedAppTests
//
//  Created by Kevin Heredia on 23/4/25.
//

import XCTest
@testable import PickedApp

final class NetworkRestaurantRegisterTest: XCTestCase {
    
    var networkRestaurantRegisterMock: NetworkRestaurantRegisterProtocol!
    var networkRestaurantRegisterFailureMock:
    NetworkRestaurantRegisterProtocol!

    override func setUpWithError() throws {
        
        networkRestaurantRegisterMock = NetworkRestaurantRegisterMock()
        networkRestaurantRegisterFailureMock = NetworkRestaurantRegisterFailureMock()
    }
    
   func testRestaurantRegisterSuccess() async {
        // Given
       let resturant = RestaurantRegisterRequest(
        email: "test@example.com",
        password: "test",
        role: "restaurant",
        restaurantName: "test",
        info: "test",
        address: "test",
        country: "test",
        city: "test",
        zipCode: "test",
        latitude: 0.0,
        longitude: 0.0,
        name: "test",
        photo: Data()
       )
       
       do {
          _ = try await networkRestaurantRegisterMock.restaurantRegister(from: resturant)
       } catch {
           XCTFail("Expected success, but got error: \(error.localizedDescription)")
       }
       
       XCTAssertEqual(resturant.name, "test")
       XCTAssertEqual(resturant.email, "test@example.com")
       XCTAssertEqual(resturant.role, "restaurant")
       XCTAssertEqual(resturant.info, "test")
       XCTAssertEqual(resturant.address, "test")
       XCTAssertEqual(resturant.country, "test")
       XCTAssertEqual(resturant.city, "test")
       XCTAssertEqual(resturant.zipCode, "test")
       XCTAssertEqual(resturant.latitude, 0.0)
       XCTAssertEqual(resturant.longitude, 0.0)
       
    }
    
    func testRestaurantRegisterFailure() async {
        
        let restaurant = RestaurantRegisterRequest(
         email: "test@example.com",
         password: "test",
         role: "restaurant",
         restaurantName: "test",
         info: "test",
         address: "test",
         country: "test",
         city: "test",
         zipCode: "test",
         latitude: 0.0,
         longitude: 0.0,
         name: "test",
         photo: Data()
        )
        
        
        do {
            _ = try await networkRestaurantRegisterFailureMock.restaurantRegister(from: restaurant)
        } catch let error as PKError {
            // 4. Verificar que sea el error esperado
            switch error {
            case .errorFromApi(let statusCode):
                XCTAssertEqual(statusCode, 400, "El código de error debería ser 400.")
            default:
                XCTFail("Se lanzó un PKError, pero no fue el esperado.")
            }
        } catch {
            XCTFail("Se lanzó un error inesperado: \(error)")
        }
        
    }
}
