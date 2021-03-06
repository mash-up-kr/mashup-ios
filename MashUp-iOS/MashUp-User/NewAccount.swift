//
//  NewAccount.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/24.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_PlatformTeam

public struct NewAccount: Equatable {
    public let id: String
    public let password: String
    public let name: String
    public let platform: PlatformTeam
    
    public init(
        id: String,
        password: String,
        name: String,
        platform: PlatformTeam
    ) {
        self.id = id
        self.password = password
        self.name = name
        self.platform = platform
    }
    
}
