//
//  Untitled.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 6/10/24.
//

@testable import Dragonball_patrones
import XCTest

final class GetHeroTransformationUseCaseTests: XCTestCase {
    let requestTransformation = Transformation(id: "1234", name: "potato", description: "", photo: "", hero: TransformationHero(id: "randomId"))
    
    func testSuccess() {
        let expectedAPIResponse = [
            Transformation(id: "1234", name: "potato", description: "", photo: "", hero: TransformationHero(id: "randomId")),
            Transformation(id: "4321", name: "potato", description: "", photo: "", hero: TransformationHero(id: "randomId"))
        ]
        let expectedResponse = Transformation(id: "1234", name: "potato", description: "", photo: "", hero: TransformationHero(id: "randomId"))
        let sut = GetHeroTransformationUseCase()
        
        let expectation = self.expectation(description: "TestSuccess")
        let data: Data
        do {
            data = try JSONEncoder().encode(expectedAPIResponse)
        } catch {
            XCTFail("Failed to encode response: \(error)")
            return
        }
        
        APISession.shared = APISessionMock { _ in .success(data) }

        sut.execute(transformation: requestTransformation) { result in
            switch result {
            case .success(let response):
                XCTAssertEqual(expectedResponse, response, "Returned transformations do not match expected transformations.")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Expected success but got failure: \(error)")
            }
        }
        
        waitForExpectations(timeout: 5)
    }
    

    func testFailure() {
        let sut = GetHeroTransformationUseCase()
        
        let expectation = self.expectation(description: "TestFailure")
        let expectedError = APIErrorResponse.network("transformations-fail")
        APISession.shared = APISessionMock { _ in .failure(expectedError) }
        
        sut.execute(transformation: requestTransformation) { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertEqual(error as? APIErrorResponse, expectedError)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5)
    }
    
}
