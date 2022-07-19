//
//  Constants.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/01/10.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

enum NetworkConfig {
    
    static var mashupHost: String {
        #if DEV
        return "https://api.dev-member.mash-up.kr"
        #else
        return "https://api.member.mash-up.kr"
        #endif
    }
    
}

struct AccessTokenCache {
    var accessToken: String?
}
