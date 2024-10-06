//
//  HeroTransformationsListViewModel.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 6/10/24.
//

import Foundation

enum HeroTransformationsListState: Equatable {
    case loading
    case error(reason: String)
    case success
}

final class HeroTransformationsListViewModel {
    let onStateChanged = Binding<HeroTransformationsListState>()
    private(set) var transformations: [Transformation] = []
    private let useCase: GetHeroTransformationsUseCaseContract
    
    init(useCase: GetHeroTransformationsUseCaseContract) {
        self.useCase = useCase
    }
    
    func load(hero: Hero) {
        onStateChanged.update(newValue: .loading)
        useCase.execute(hero: hero) { [weak self] result in
            do {
                self?.transformations = try result.get()
                self?.onStateChanged.update(newValue: .success)
            } catch {
                self?.onStateChanged.update(newValue: .error(reason: error.localizedDescription))
            }
        }
    }
}
