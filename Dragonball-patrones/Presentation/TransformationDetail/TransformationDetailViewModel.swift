//
//  TransformationDetailViewModel.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 6/10/24.
//

import Foundation

enum TransformationDetailState: Equatable {
    case loading
    case error(reason: String)
    case success
}

final class TransformationDetailViewModel {
    let onStateChanged = Binding<TransformationDetailState>()
    private(set) var transformation: Transformation?
    private let useCase: GetHeroTransformationUseCaseContract
    
    init(useCase: GetHeroTransformationUseCaseContract) {
        self.useCase = useCase
    }
    
    func load(transformation: Transformation) {
        onStateChanged.update(newValue: .loading)
        useCase.execute(transformation: transformation) { [weak self] result in
            do {
                self?.transformation = try result.get()
                self?.onStateChanged.update(newValue: .success)
            } catch {
                self?.onStateChanged.update(newValue: .error(reason: error.localizedDescription))
            }
        }
    }
}
