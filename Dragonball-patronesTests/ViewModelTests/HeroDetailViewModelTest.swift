//
//  HeroDetailViewModelTest.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 6/10/24.
//


@testable import Dragonball_patrones
import XCTest

private final class SuccessGetHeroUseCaseMock: GetHeroUseCaseContract {
    func execute(hero: Hero, completion: @escaping (Result<[Dragonball_patrones.Hero], any Error>) -> Void) {
        completion(.success([Hero(identifier: "1234",
                                  name: "potato",
                                  description: "",
                                  photo: "",
                                  favorite: false)]))
    }
}

private final class FailedGetHeroUseCaseMock: GetHeroUseCaseContract {
    func execute(hero: Hero, completion: @escaping (Result<[Dragonball_patrones.Hero], any Error>) -> Void) {
        completion(.failure(APIErrorResponse.unknown("")))
    }
}


final class HeroDetailViewModelTests: XCTestCase {
    let hero = Hero(identifier: "randomID", name: "randomName", description: "randomDescription", photo: "randomPhoto", favorite: false)
    
    func testSuccessScenario() {
        let successExpectation = expectation(description: "Success")
        let loadingExpectation = expectation(description: "Loading")
        let useCaseMock = SuccessGetHeroUseCaseMock()
        let sut = HeroDetailViewModel(useCase: useCaseMock)
        
        sut.onStateChanged.bind { state in
            if state == .loading {
                loadingExpectation.fulfill()
            } else if state == .success {
                successExpectation.fulfill()
            }
        }
        
        sut.load(hero: hero)
        waitForExpectations(timeout: 5)
        XCTAssertEqual(sut.hero.count, 1)
    }
    
    func testFailScenario() {
        let errorExpectation = expectation(description: "Error")
        let loadingExpectation = expectation(description: "Loading")
        let useCaseMock = FailedGetHeroUseCaseMock()
        let sut = HeroDetailViewModel(useCase: useCaseMock)
        
        sut.onStateChanged.bind { state in
            if state == .loading {
                loadingExpectation.fulfill()
            } else if case .error = state {
                errorExpectation.fulfill()
            }
        }
        
        sut.load(hero: hero)
        waitForExpectations(timeout: 5)
        XCTAssertEqual(sut.hero.count, 0)
    }
}
