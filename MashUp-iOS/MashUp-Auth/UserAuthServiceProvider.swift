//
//  UserAuthServiceProvider.swift
//  MashUp-Auth
//
//  Created by Booung on 2022/07/14.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_Network

public final class UserAuthServiceProvider {
    
    public init() {}
    
    public func provide() -> any UserAuthService {
        let network = HTTPClient()
        let userSessionRepository = UserSessionRepositoryImp(network: network)
        let userAuthService = UserAuthServiceImp(userSessionRepository: userSessionRepository)
        return userAuthService
    }
    
}
