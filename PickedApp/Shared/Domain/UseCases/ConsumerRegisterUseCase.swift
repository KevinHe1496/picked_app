//
//  ConsumerRegisterUseCase.swift
//  PickedApp
//
//  Created by Kevin Heredia on 15/4/25.
//

import Foundation

protocol ConsumerRegisterUseCaseProtocol {
    var repo: ConsumerRegisterRepositoryProtocol { get set }
    func consumerRegisterUser(name: String, email: String, password: String, role: String) async throws -> Bool
}

final class ConsumerRegisterUseCase: ConsumerRegisterUseCaseProtocol {
    
    var repo: ConsumerRegisterRepositoryProtocol
    
    init(repo: ConsumerRegisterRepositoryProtocol = DefaultConsumerRegisterRepository()) {
        self.repo = repo
    }
    
    func consumerRegisterUser(name: String, email: String, password: String, role: String) async throws -> Bool {
        return try await repo.consumerRegister(name: name, email: email, password: password, role: role)
    }
}
