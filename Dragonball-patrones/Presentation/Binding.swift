//
//  Binding.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 4/10/24.
//

import Foundation

final class Binding<State> {
    typealias Completion = (State) -> Void
    
    var completion: Completion?
    
    func bind(completion: @escaping Completion) {
        self.completion = completion
    }
    
    func update(newValue: State) {
        DispatchQueue.main.async { [weak self] in
            self?.completion?(newValue)
        }
    }
}
