//
//  DefaultConsumerRegisterRepository.swift
//  PickedApp
//
//  Created by Kevin Heredia on 15/4/25.
//

import Foundation

final class DefaultConsumerRegisterRepository: ConsumerRegisterRepositoryProtocol {
    private var network: NetworkConsumerRegisterProtocol
    
    init(network: NetworkConsumerRegisterProtocol = NetworkConsumerRegister()) {
        self.network = network
    }
    
    func consumerRegister(name: String, email: String, password: String, role: String) async throws -> Bool{
        do {
            try await network.consumerRegister(name: name, email: email, password: password, role: role)
            return true
        } catch {
            throw error
        }
    }
}

final class DefaultConsumerRegisterRepositoryMock: ConsumerRegisterRepositoryProtocol {
    private var network: NetworkConsumerRegisterProtocol
    
    init(network: NetworkConsumerRegisterProtocol = NetworkConsumerRegisterMock()) {
        self.network = network
    }
    
    func consumerRegister(name: String, email: String, password: String, role: String) async throws -> Bool{
        do {
            try await network.consumerRegister(name: name, email: email, password: password, role: role)
            return true
        } catch {
            throw error
        }
    }
}
