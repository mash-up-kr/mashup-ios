//
//  RootStep.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/25.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_Auth
import MashUp_User

enum RootStep: Equatable {
    case splash
    case signIn
    case home(UserSession)
}
