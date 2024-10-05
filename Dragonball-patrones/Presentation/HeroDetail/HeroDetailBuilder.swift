//
//  HeroDetailBuilder.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 5/10/24.
//

import UIKit

final class HeroDetailBuilder {
    func build(hero: Hero) -> UIViewController {
        let useCase = GetHeroUseCase()
        let viewModel = HeroDetailViewModel(useCase: useCase)
        let viewController = HeroDetailViewController(hero: hero, viewModel: viewModel)
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
}
