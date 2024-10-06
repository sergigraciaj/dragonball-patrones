//
//  GetHeroesUseCase.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 6/10/24.
//

@testable import Dragonball_patrones
import XCTest

final class GetHeroUseCaseTests: XCTestCase {
    let requestHero = Hero(identifier: "randomID", name: "randomName", description: "randomDescription", photo: "randomPhoto", favorite: false)
    
    func testSuccess() {
        let responseHero: [Hero] = [requestHero]
        let sut = GetHeroUseCase()
        
        let expectation = self.expectation(description: "TestSuccess")
        let data: Data
        do {
            data = try JSONEncoder().encode(responseHero)
        } catch {
            XCTFail("Failed to encode heroes: \(error)")
            return
        }
        
        APISession.shared = APISessionMock { _ in .success(data) }

        sut.execute(hero: requestHero) { result in
            switch result {
            case .success(let returnedHeroe):
                XCTAssertEqual(returnedHeroe, responseHero, "Returned hero do not match expected heroes.")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Expected success but got failure: \(error)")
            }
        }
        
        waitForExpectations(timeout: 5)
    }
    

    func testFailure() {
        let sut = GetHeroUseCase()
        
        let expectation = self.expectation(description: "TestFailure")
        let expectedError = APIErrorResponse.network("hero-fail")
        APISession.shared = APISessionMock { _ in .failure(expectedError) }
        
        sut.execute(hero: requestHero) { result in
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
