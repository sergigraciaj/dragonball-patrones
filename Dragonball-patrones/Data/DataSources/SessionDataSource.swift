//
//  SessionDataSource.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 4/10/24.
//

import Foundation

protocol SessionDataSourceContract {
    func storeSession(_ session: Data)
    
    func getSession() -> Data?
}

final class SessionDataSource: SessionDataSourceContract {
    private static var token: Data?
    
    func storeSession(_ session: Data) {
        SessionDataSource.token = session
    }
    
    func getSession() -> Data? {
        SessionDataSource.token
    }
}
