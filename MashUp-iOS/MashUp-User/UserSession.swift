//
//  UserSession.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/24.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_PlatformTeam

public struct UserSession: Equatable {
    
    public typealias ID = String
    
    public let id: String
    public let accessToken: String
    public let name: String
    public let platformTeam: PlatformTeam
    
    public init(
        id: String,
        accessToken: String,
        name: String,
        platformTeam: PlatformTeam
    ) {
        self.id = id
        self.accessToken = accessToken
        self.name = name
        self.platformTeam = platformTeam
    }
    
}
