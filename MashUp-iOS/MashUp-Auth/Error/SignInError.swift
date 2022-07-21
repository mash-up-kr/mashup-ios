//
//  SignInError.swift
//  MashUp-Auth
//
//  Created by Booung on 2022/07/20.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_Core

public enum SignInError: String, Error {
    case idError = "MEMBER_NOT_FOUND"
    case passwordError = "MEMBER_NOT_MATCH_PASSWORD"
    case undefined
}

public extension MashUpError {
    var asSignInError: SignInError {
        return SignInError(rawValue: self.code) ?? .undefined
    }
}
