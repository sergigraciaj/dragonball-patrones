//
//  GetHeroTransformationUseCase.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 6/10/24.
//

import Foundation

protocol GetHeroTransformationsUseCaseContract {
    func execute(hero: Hero, completion: @escaping (Result<[Transformation], Error>) -> Void)
}

final class GetHeroTransformationsUseCase: GetHeroTransformationsUseCaseContract {
    func execute(hero: Hero, completion: @escaping (Result<[Transformation], any Error>) -> Void) {
        GetHeroTransformationsAPIRequest(id: hero.identifier)
            .perform { result in
                do {
                    try completion(.success(result.get()))
                } catch {
                    completion(.failure(error))
                }
            }
    }
}
