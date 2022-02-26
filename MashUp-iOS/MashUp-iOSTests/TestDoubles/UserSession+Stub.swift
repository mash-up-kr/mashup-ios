//
//  UserSession+Stub.swift
//  MashUp-iOSTests
//
//  Created by Booung on 2022/02/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
@testable import MashUp_iOS

extension UserSession {
  static func stub(accessToken: String) -> Self {
    return UserSession(accessToken: accessToken)
  }
}
