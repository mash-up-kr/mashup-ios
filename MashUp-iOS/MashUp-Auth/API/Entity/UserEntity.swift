//
//  SignInResponse.swift
//  MashUp-Auth
//
//  Created by Booung on 2022/07/18.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

struct UserEntity: Decodable {
    let userID: Int
    let userName: String
    let accessToken: String
    let platform: String
    let generationNumber: Int
    
    enum CodingKeys: String, CodingKey {
        case userID = "memberId"
        case userName = "name"
        case accessToken = "token"
        case platform
        case generationNumber
    }
}
