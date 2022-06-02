//
//  NewAccount.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/24.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

public enum PlatformTeam: Equatable, CaseIterable {
    case design
    case android
    case iOS
    case web
    case node
    case spring
}

public struct NewAccount: Equatable {
    public let id: String
    public let password: String
    public let name: String
    public let platform: PlatformTeam
    public let phoneNumber: String
}
