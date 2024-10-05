//
//  APIInterceptor.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 4/10/24.
//

import Foundation

protocol APIInterceptor { }

protocol APIRequestInterceptor: APIInterceptor {
    func intercept(request: inout URLRequest)
}

final class AuthenticationRequestInterceptor: APIRequestInterceptor {
    private let dataSource: SessionDataSourceContract
    
    init(dataSource: SessionDataSourceContract = SessionDataSource()) {
        self.dataSource = dataSource
    }
    
    func intercept(request: inout URLRequest) {
        /*
         guard let session = dataSource.getSession() else {
            return
        }
         */
        let token = "eyJraWQiOiJwcml2YXRlIiwiYWxnIjoiSFMyNTYiLCJ0eXAiOiJKV1QifQ.eyJleHBpcmF0aW9uIjo2NDA5MjIxMTIwMCwiaWRlbnRpZnkiOiI1RTNGRTU1Ri0wM0FBLTRFMjgtOUI2NC0xQjJFOTgzRjkxMzkiLCJlbWFpbCI6InNlcmdpb2dqMTk5MEBnbWFpbC5jb20ifQ.i1rP1O6q_7oCjEds7iHNSTBWK3Lvnz8p0__-0PoM2wg"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        //request.setValue("Bearer \(String(decoding: session, as: UTF8.self))", forHTTPHeaderField: "Authorization")
    }
}
