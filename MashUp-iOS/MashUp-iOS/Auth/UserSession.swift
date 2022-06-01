//
//  UserSession.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/24.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

struct UserSession: Equatable {
    typealias ID = String
    
    let id: String
    let accessToken: String
}
