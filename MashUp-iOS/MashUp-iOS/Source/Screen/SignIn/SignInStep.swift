//
//  SignInStep.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/25.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

enum SignInStep: Equatable {
    case signUp
    case home(UserSession)
}
