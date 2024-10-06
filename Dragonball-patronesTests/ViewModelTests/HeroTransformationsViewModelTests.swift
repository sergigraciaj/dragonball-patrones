//
//  HeroTransformationsViewModelTests.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 6/10/24.
//

@testable import Dragonball_patrones
import XCTest

private final class SuccessGetHeroTransformationsUseCaseMock: GetHeroTransformationsUseCaseContract {
    func execute(hero: Dragonball_patrones.Hero, completion: @escaping (Result<[Dragonball_patrones.Transformation], any Error>) -> Void) {
        completion(.success([Transformation(id: "1234", name: "potato", description: "", photo: "", hero: TransformationHero(id: "randomId"))]))
    }
}

private final class FailedGetHeroTransformationsUseCaseMock: GetHeroTransformationsUseCaseContract {
    func execute(hero: Dragonball_patrones.Hero, completion: @escaping (Result<[Dragonball_patrones.Transformation], any Error>) -> Void) {
        completion(.failure(APIErrorResponse.unknown("")))
    }
}


final class HeroTransformationsListViewModelTests: XCTestCase {
    let hero = Hero(identifier: "randomID", name: "randomName", description: "randomDescription", photo: "randomPhoto", favorite: false)

    func testSuccessScenario() {
        let successExpectation = expectation(description: "Success")
        let loadingExpectation = expectation(description: "Loading")
        let useCaseMock = SuccessGetHeroTransformationsUseCaseMock()
        let sut = HeroTransformationsListViewModel(useCase: useCaseMock)
        
        sut.onStateChanged.bind { state in
            if state == .loading {
                loadingExpectation.fulfill()
            } else if state == .success {
                successExpectation.fulfill()
            }
        }
        
        sut.load(hero: hero)
        waitForExpectations(timeout: 5)
        XCTAssertEqual(sut.transformations.count, 1)
    }
    
    func testFailScenario() {
        let errorExpectation = expectation(description: "Error")
        let loadingExpectation = expectation(description: "Loading")
        let useCaseMock = FailedGetHeroTransformationsUseCaseMock()
        let sut = HeroTransformationsListViewModel(useCase: useCaseMock)
        
        sut.onStateChanged.bind { state in
            if state == .loading {
                loadingExpectation.fulfill()
            } else if case .error = state {
                errorExpectation.fulfill()
            }
        }
        
        sut.load(hero: hero)
        waitForExpectations(timeout: 5)
        XCTAssertEqual(sut.transformations.count, 0)
    }
}
