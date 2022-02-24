//
//  RootStep.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/25.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

enum RootStep {
    case splash
    case signIn
    case home(UserSession)
}
