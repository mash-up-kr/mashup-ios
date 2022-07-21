//
//  AccessToken.swift
//  MashUp-Network
//
//  Created by Booung on 2022/07/21.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_Core

@propertyWrapper
struct Bearer {
    var wrappedValue: AccessToken? {
        get { self.accessToken }
        set {
            guard let accessToken = newValue else { return self.accessToken = nil }
            guard accessToken.isNotEmpty else { return self.accessToken = .empty }
            self.accessToken = "Bearer \(accessToken)"
        }
    }
    
    init(wrappedValue accessToken: AccessToken?) {
        self.wrappedValue = accessToken
    }
    
    private var accessToken: AccessToken?
    
}
