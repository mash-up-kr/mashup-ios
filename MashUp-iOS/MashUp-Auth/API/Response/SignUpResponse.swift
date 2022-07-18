//
//  SignUpResponse.swift
//  MashUp-Auth
//
//  Created by Booung on 2022/07/14.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

struct SignUpResponse: Decodable {
    
    let accessToken: String
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "token"
    }
    
}

