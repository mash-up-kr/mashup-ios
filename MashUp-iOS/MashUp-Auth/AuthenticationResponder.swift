//
//  AuthenticationResponder.swift
//  MashUp-Auth
//
//  Created by Booung on 2022/06/03.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_User

public protocol AuthenticationResponder {
    func loadSuccess(userSession: UserSession)
    func loadFailure()
}
