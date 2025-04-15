//
//  LoginUseCase.swift
//  PickedApp
//
//  Created by Kevin Heredia on 14/4/25.
//

import Foundation

protocol LoginUseCaseProtocol {
    var repo: LoginRepositoryProtocol { get set }
    
    func loginUser(user: String, password: String) async throws -> Bool
    func logout() async -> Void
    func validateToken() async -> Bool
}

final class LoginUseCase: LoginUseCaseProtocol {
    var repo: LoginRepositoryProtocol
    
    @pkPersistenceKeychain(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
    var tokenJWT
    
    init(repo: LoginRepositoryProtocol = DefaultLoginRepository()) {
        self.repo = repo
    }
    
    func loginUser(user: String, password: String) async throws -> Bool {
        let token = try await repo.loginUser(user: user, password: password)
        
        if token != ""{
            tokenJWT = token
            return true
        } else {
            tokenJWT = ""
            return false
        }
    }
    
    func logout() async {
        KeyChainPK().deletePK(key: ConstantsApp.CONS_TOKEN_ID_KEYCHAIN)
    }
    
    func validateToken() async -> Bool {
        if tokenJWT != ""{
            return true
        } else {
            return false
        }
    }
}


///MOCK SUCCESS
final class LoginUseCaseSucessMock: LoginUseCaseProtocol {
    var repo: LoginRepositoryProtocol
    var token: String = ""
    
    init(repo: LoginRepositoryProtocol = DefaultLoginRepositoryMock()) {
        self.repo = repo
    }
    
    func loginUser(user: String, password: String) async throws -> Bool {
        let result = try await repo.loginUser(user: user, password: password)
        token = result
        return !token.isEmpty
    }
    
    func logout() async {
        token = ""
    }
    
    func validateToken() async -> Bool {
        return !token.isEmpty
    }
}


///MOCK FAILURE
final class LoginUseCaseFailureMock: LoginUseCaseProtocol {
    var repo: LoginRepositoryProtocol = DefaultLoginRepositoryMock()
    
    func loginUser(user: String, password: String) async throws -> Bool {
        return false
    }
    
    func logout() async { }
    
    func validateToken() async -> Bool {
        return false
    }
}
