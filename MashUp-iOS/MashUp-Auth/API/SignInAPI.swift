//
//  SignInAPI.swift
//  MashUp-Auth
//
//  Created by Booung on 2022/07/18.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_Network
import MashUp_PlatformTeam

struct SignInAPI {
    let id: String
    let password: String
}
extension SignInAPI: MashUpAPI {
    typealias Response = SignInResponse
    
    var path: String { "/api/v1/members/login" }
    var httpMethod: HTTPMethod { .post }
    
    var httpTask: HTTPTask {
        return .requestParameters(
            parameters: ["identification": self.id, "password": self.password],
            encoding: JSONEncoding.default
        )
    }
    
    var headers: [String : String]? { [:] }
    
}
