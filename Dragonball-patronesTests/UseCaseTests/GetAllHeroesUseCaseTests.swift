//
//  GetAllHeroesUseCaseTests.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 6/10/24.
//

@testable import Dragonball_patrones
import XCTest

final class GetAllHeroesUseCaseTests: XCTestCase {
    
    func testSuccess() {
        let sut = GetAllHeroesUseCase()
        let heroes: [Hero] = [
            Hero(identifier: "randomID", name: "randomName", description: "randomDescription", photo: "randomPhoto", favorite: false),
            Hero(identifier: "randomID", name: "randomName", description: "randomDescription", photo: "randomPhoto", favorite: false)
        ]
        
        let expectation = self.expectation(description: "TestSuccess")
        let data: Data
        do {
            data = try JSONEncoder().encode(heroes)
        } catch {
            XCTFail("Failed to encode heroes: \(error)")
            return
        }
        
        APISession.shared = APISessionMock { _ in .success(data) }

        sut.execute { result in
            switch result {
            case .success(let returnedHeroes):
                XCTAssertEqual(returnedHeroes, heroes, "Returned heroes do not match expected heroes.")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Expected success but got failure: \(error)")
            }
        }
        
        waitForExpectations(timeout: 5)
    }
    

    func testFailure() {
        let sut = GetAllHeroesUseCase()
        
        let expectation = self.expectation(description: "TestFailure")
        let expectedError = APIErrorResponse.network("heroes-fail")
        APISession.shared = APISessionMock { _ in .failure(expectedError) }
        
        sut.execute { result in
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
