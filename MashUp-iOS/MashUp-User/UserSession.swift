//
//  UserSession.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/24.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

public struct UserSession: Equatable {
    
    public typealias ID = String
    
    public let id: String
    public let accessToken: String
    
    public init(id: String, accessToken: String) {
        self.id = id
        self.accessToken = accessToken
    }
    
}
