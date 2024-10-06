//
//  GetHeroTransformation.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 6/10/24.
//

import Foundation

struct GetHeroTransformationsAPIRequest: APIRequest {
    typealias Response = [Transformation]
    
    let path: String = "/api/heros/tranformations"
    let method: HTTPMethod = .POST
    let body: (any Encodable)?
    
    init(id: String) {
        body = RequestEntity(id: id)
    }
}

private extension GetHeroTransformationsAPIRequest {
    struct RequestEntity: Encodable {
        let id: String
    }
}
