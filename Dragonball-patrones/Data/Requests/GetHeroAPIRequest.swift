//
//  GetHeroAPIRequest.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 5/10/24.
//

import Foundation

struct GetHeroAPIRequest: APIRequest {
    typealias Response = [Hero]
    
    let path: String = "/api/heros/all"
    let method: HTTPMethod = .POST
    let body: (any Encodable)?
    
    init(name: String?) {
        body = RequestEntity(name: name ?? "")
    }
}

private extension GetHeroAPIRequest {
    struct RequestEntity: Encodable {
        let name: String
    }
}
