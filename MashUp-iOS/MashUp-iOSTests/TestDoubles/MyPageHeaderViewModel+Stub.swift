//
//  MyPageHeaderViewModel+Stub.swift
//  MashUp-iOSTests
//
//  Created by Booung on 2022/07/10.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
@testable import MashUp_iOS

extension MyPageHeaderViewModel {
  
  static func stub(
    userName: String = "stub.user.name.\(Date.now())",
    platformTeamText: String = "stub.platform.\(Date.now())",
    totalScoreText: String = "stub.total.score.\(Date.now())"
  ) -> Self {
    return MyPageHeaderViewModel(
      userName: userName,
      platformTeamText: platformTeamText,
      totalScoreText: totalScoreText
    )
  }
  
}
