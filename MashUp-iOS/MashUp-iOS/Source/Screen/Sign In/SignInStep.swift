//
//  SignInStep.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/25.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_Auth

enum SignInStep: Equatable {
    case signUp(AuthenticationResponder)
}
extension SignInStep {
    static func == (lhs: SignInStep, rhs: SignInStep) -> Bool {
        switch (lhs, rhs) {
        case (.signUp, .signUp): return true
        }
    }
}
