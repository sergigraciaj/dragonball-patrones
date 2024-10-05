//
//  GetHeroUseCase.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 5/10/24.
//

import Foundation

protocol GetHeroUseCaseContract {
    func execute(hero: Hero, completion: @escaping (Result<[Hero], Error>) -> Void)
}

final class GetHeroUseCase: GetHeroUseCaseContract {
    func execute(hero: Hero, completion: @escaping (Result<[Hero], any Error>) -> Void) {
        GetHeroesAPIRequest(name: hero.name)
            .perform { result in
                do {
                    try completion(.success(result.get()))
                } catch {
                    completion(.failure(error))
                }
            }
    }
}
