//
//  HeroTransformationsListBuilder.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 6/10/24.
//

import UIKit

final class HeroTransformationListBuilder {
    func build(hero: Hero) -> UIViewController {
        let useCase = GetHeroTransformationsUseCase()
        let viewModel = HeroTransformationsListViewModel(useCase: useCase)
        let viewController = HeroTransformationListViewController(hero: hero, viewModel: viewModel)
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
}
