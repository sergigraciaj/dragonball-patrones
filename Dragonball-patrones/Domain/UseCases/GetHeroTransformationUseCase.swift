//
//  GetHeroTransformationUseCase.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 6/10/24.
//

import Foundation

protocol GetHeroTransformationUseCaseContract {
    func execute(transformation: Transformation, completion: @escaping (Result<Transformation, Error>) -> Void)
}

final class GetHeroTransformationUseCase: GetHeroTransformationUseCaseContract {
    var transformations: [Transformation] = []
    
    func execute(transformation: Transformation, completion: @escaping (Result<Transformation, any Error>) -> Void) {
        GetHeroTransformationsAPIRequest(id: transformation.hero.id)
            .perform { [weak self] result in
                do {
                    self?.transformations = try result.get()
                    let resultTransformation = self?.transformations.filter( { $0.id == transformation.id})[0]
                    guard let resultTransformation else {
                        return
                    }
                    completion(.success(resultTransformation))
                } catch {
                    completion(.failure(error))
                }
            }
    }
}
