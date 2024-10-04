//
//  Hero.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 4/10/24.
//

struct Hero: Equatable, Decodable {
    let identifier: String
    let name: String
    let description: String
    let photo: String
    let favorite: Bool
    
    enum CodingKeys: String, CodingKey {
        case identifier = "id"
        case name
        case description
        case photo
        case favorite
    }
}
