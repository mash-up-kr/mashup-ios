//
//  SignUpAPI.swift
//  MashUp-Auth
//
//  Created by Booung on 2022/07/14.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_Network

struct SignUpAPI: MashUpAPI {
    let id: String
    let name: String
    let password: String
    let privatePolicyAgreed: Bool = true
    let platform: String
    let signUpCode: String
}
extension SignUpAPI {
    
    typealias Response = SignUpResponse
    
    var path: String { "/api/v1/members/signup" }
    var httpMethod: HTTPMethod { .post }
    var httpTask: HTTPTask {
        let parameters: [String : Any] = [
            "identification": self.id,
            "name": self.name,
            "inviteCode": self.signUpCode,
            "password": self.password,
            "platform": self.platform,
            "privatePolicyAgreed": true
        ]
        return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
    }
    var headers: [String : String]? { nil }
    
}
