//
//  LoginBuilder.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 4/10/24.
//

import UIKit

final class LoginBuilder {
    func build() -> UIViewController {
        let loginUseCase = LoginUseCase()
        let viewModel = LoginViewModel(useCase: loginUseCase)
        let viewController = LoginViewController(viewModel: viewModel)
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
}
