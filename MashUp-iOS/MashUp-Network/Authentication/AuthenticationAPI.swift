//
//  AuthenticationAPI.swift
//  MashUp-Network
//
//  Created by Booung on 2022/07/20.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

struct AuthenticationAPI {}

extension AuthenticationAPI: MashUpAPI {
    var path: String { "/api/v1/members/token"}
    var headers: [String : String]? { nil }
    var httpTask: HTTPTask { .requestPlain }
    var httpMethod: HTTPMethod { .post }
}

extension AuthenticationAPI {
    
    struct Response: Decodable, Authorization {
        let accessToken: String
        
        enum CodingKeys: String, CodingKey {
            case accessToken = "token"
        }
    }
    
}

