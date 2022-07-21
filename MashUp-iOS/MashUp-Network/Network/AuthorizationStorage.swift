//
//  AuthorizationStorage.swift
//  MashUp-Network
//
//  Created by Booung on 2022/07/20.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_Core

public protocol AuthorizationStorage {
    func fetchAccessToken() -> String?
    func saveAccessToken(_ accessToken: String)
    func deleteAccessToken()
}

#warning("싱글턴 제거 되어야합니다 - booung")
final class AuthorizationStorageImp: AuthorizationStorage {
    
    static var shared = AuthorizationStorageImp()
    
    func fetchAccessToken() -> String? {
        return self.accessToken
    }
    
    func saveAccessToken(_ accessToken: String) {
        self.accessToken = accessToken
    }
    
    func deleteAccessToken() {
        self.accessToken = nil
    }
    
    @Bearer private var accessToken: AccessToken?
    
}
