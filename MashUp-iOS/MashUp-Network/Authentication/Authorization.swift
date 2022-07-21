//
//  Authorization.swift
//  MashUp-Network
//
//  Created by Booung on 2022/07/20.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_Core

public protocol Authorization {
    var accessToken: AccessToken { get }
}
