//
//  LoginViewModel.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 6/10/24.
//

@testable import Dragonball_patrones
import XCTest

private final class SuccessLoginCaseMock: LoginUseCaseContract {
    func execute(credentials: Credentials, completion: @escaping (Result<Void, LoginUseCaseError>) -> Void) {
        completion(.success(()))
    }
}

private final class FailedLoginUseCaseMock: LoginUseCaseContract {
    func execute(credentials: Credentials, completion: @escaping (Result<Void, LoginUseCaseError>) -> Void) {
        completion(.failure(LoginUseCaseError(reason: "Network failed")))
    }
}


final class LoginViewModelTests: XCTestCase {
    let credentials = Credentials(username: "randomName", password: "randomPassword")
    
    func testSuccessScenario() {
        let successExpectation = expectation(description: "Success")
        let loadingExpectation = expectation(description: "Loading")
        let useCaseMock = SuccessLoginCaseMock()
        let sut = LoginViewModel(useCase: useCaseMock)
        var stateChanged: LoginState?
        
        sut.onStateChanged.bind { newState in
            stateChanged = newState
            if stateChanged == .loading {
                loadingExpectation.fulfill()
            } else if stateChanged == .success {
                successExpectation.fulfill()
            }
        }
        
        sut.signIn(credentials.username, credentials.password)
        waitForExpectations(timeout: 5)
        XCTAssertEqual(stateChanged, .success)
    }
    
    func testFailScenario() {
        let errorExpectation = expectation(description: "Error")
        let loadingExpectation = expectation(description: "Loading")
        let useCaseMock = FailedLoginUseCaseMock()
        let sut = LoginViewModel(useCase: useCaseMock)
        var stateChanged: LoginState?
        
        sut.onStateChanged.bind { newState in
            stateChanged = newState
            if stateChanged == .loading {
                loadingExpectation.fulfill()
            } else if case .error = stateChanged {
                errorExpectation.fulfill()
            }
        }
        
 
        
        sut.signIn(credentials.username, credentials.password)
        waitForExpectations(timeout: 5)
        XCTAssertEqual(stateChanged, .error(reason: "Network failed"))
    }
}
