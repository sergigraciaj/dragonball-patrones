//
//  HeroDetailViewModel.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 5/10/24.
//

import Foundation

enum HeroDetailState: Equatable {
    case loading
    case error(reason: String)
    case success
}

final class HeroDetailViewModel {
    let onStateChanged = Binding<HeroDetailState>()
    private(set) var hero: [Hero] = []
    private let useCase: GetHeroUseCaseContract
    
    init(useCase: GetHeroUseCaseContract) {
        self.useCase = useCase
    }
    
    func load(hero: Hero) {
        onStateChanged.update(newValue: .loading)
        useCase.execute(hero: hero) { [weak self] result in
            do {
                self?.hero = try result.get()
                self?.onStateChanged.update(newValue: .success)
            } catch {
                self?.onStateChanged.update(newValue: .error(reason: error.localizedDescription))
            }
        }
    }
}
