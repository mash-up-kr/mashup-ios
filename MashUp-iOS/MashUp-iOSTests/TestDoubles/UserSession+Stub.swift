//
//  UserSession+Stub.swift
//  MashUp-iOSTests
//
//  Created by Booung on 2022/02/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

import MashUp_User
import MashUp_PlatformTeam
@testable import MashUp_iOS

extension UserSession {
  static func stub(
    id: String = "fake.id.\(Date.now())",
    accessToken: String = "fake.accessToken.\(Date.now())",
    name: String = "fake.name.\(UUID().uuidString)",
    platformTeam: PlatformTeam = PlatformTeam.allCases.randomElement()!
  ) -> Self {
    return UserSession(
      id: id,
      accessToken: accessToken,
      name: name,
      platformTeam: platformTeam
    )
  }
}
