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
    let signUpCode: String
}
extension SignUpAPI {
    
    typealias Response = SignUpResponse
    
    var path: String { "/api/v1/member" }
    var httpMethod: HTTPMethod { .post }
    var httpTask: HTTPTask { .requestPlain }
    var headers: [String : String]? { nil }
    
}
