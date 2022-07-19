//
//  SignUpError.swift
//  MashUp-Auth
//
//  Created by Booung on 2022/07/14.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_Core

public enum SignUpError: String, Error {
    case wrongInviteCode = "MEMBER_INVALID_INVITE"
    case undefined
}

extension MashUpError {
    var asSignUpError: SignUpError {
        return SignUpError(rawValue: self.code) ?? .undefined
    }
}
