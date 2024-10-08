//
//  LoginApiRequest.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 4/10/24.
//

import Foundation

struct LoginAPIRequest: APIRequest {
    typealias Response = Data
    
    let headers: [String: String]
    let method: HTTPMethod = .POST
    let path: String = "/api/auth/login"
    
    init(credentials: Credentials) {
        let loginData = Data(String(format: "%@:%@", credentials.username, credentials.password).utf8)
        let base64String = loginData.base64EncodedString()
        headers = ["Authorization": "Basic \(base64String)"]
    }
}

