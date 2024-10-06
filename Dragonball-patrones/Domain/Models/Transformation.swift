//
//  Transformation.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 6/10/24.
//

struct Transformation: Codable, Equatable {
    let id: String
    let name: String
    let description: String
    let photo: String
    let hero: TransformationHero
}

struct TransformationHero: Codable, Equatable {
    let id: String
}
