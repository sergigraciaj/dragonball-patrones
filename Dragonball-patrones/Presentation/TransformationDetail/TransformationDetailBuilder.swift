//
//  TransformationDetailBuilder.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 6/10/24.
//

import UIKit

final class TransformationDetailBuilder {
    func build(transformation: Transformation) -> UIViewController {
        let useCase = GetHeroTransformationUseCase()
        let viewModel = TransformationDetailViewModel(useCase: useCase)
        let viewController = TransformationDetailViewController(transformation: transformation, viewModel: viewModel)
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
}
