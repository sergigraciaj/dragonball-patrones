//
//  HeroTransformationsViewModelTests.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 6/10/24.
//

@testable import Dragonball_patrones
import XCTest

private final class SuccessGetHeroTransformationUseCaseMock: GetHeroTransformationUseCaseContract {
    func execute(transformation: Dragonball_patrones.Transformation, completion: @escaping (Result<Dragonball_patrones.Transformation, any Error>) -> Void) {
        completion(.success(Transformation(id: "1234", name: "potato", description: "", photo: "", hero: TransformationHero(id: "randomId"))))
    }
}

private final class FailedGetHeroTransformationUseCaseMock: GetHeroTransformationUseCaseContract {
    func execute(transformation: Dragonball_patrones.Transformation, completion: @escaping (Result<Dragonball_patrones.Transformation, any Error>) -> Void) {
        completion(.failure(APIErrorResponse.unknown("")))
    }
}


final class TransformationDetailViewModelTests: XCTestCase {
    let transformation = Transformation(id: "1234", name: "potato", description: "", photo: "", hero: TransformationHero(id: "randomId"))

    func testSuccessScenario() {
        let successExpectation = expectation(description: "Success")
        let loadingExpectation = expectation(description: "Loading")
        let useCaseMock = SuccessGetHeroTransformationUseCaseMock()
        let sut = TransformationDetailViewModel(useCase: useCaseMock)
        
        sut.onStateChanged.bind { state in
            if state == .loading {
                loadingExpectation.fulfill()
            } else if state == .success {
                successExpectation.fulfill()
            }
        }
        
        sut.load(transformation: transformation)
        waitForExpectations(timeout: 5)
        XCTAssert(sut.transformation != nil)
    }
    
    func testFailScenario() {
        let errorExpectation = expectation(description: "Error")
        let loadingExpectation = expectation(description: "Loading")
        let useCaseMock = FailedGetHeroTransformationUseCaseMock()
        let sut = TransformationDetailViewModel(useCase: useCaseMock)
        
        sut.onStateChanged.bind { state in
            if state == .loading {
                loadingExpectation.fulfill()
            } else if case .error = state {
                errorExpectation.fulfill()
            }
        }
        
        sut.load(transformation: transformation)
        waitForExpectations(timeout: 5)
        XCTAssert(sut.transformation == nil)
    }
}
