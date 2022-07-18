//
//  ClubActivityHistoryCellModel+Stub.swift
//  MashUp-iOSTests
//
//  Created by Booung on 2022/07/10.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

@testable import MashUp_iOS

extension ClubActivityHistoryCellModel {
  
  static func stub(
    description: String = "stub.description.\(UUID().uuidString)",
    clubActivityStyle: ClubActivityStyle = .allCases.randomElement()!,
    scoreChangeStyle: ScoreChangeStyle = .custom(UUID().uuidString),
    appliedTotalScoreText: String = "stub.total.score.\(UUID().uuidString)"
  ) -> Self {
    return ClubActivityHistoryCellModel(
      description: description,
      clubActivityStyle: clubActivityStyle,
      scoreChangeStyle: scoreChangeStyle,
      appliedTotalScoreText: appliedTotalScoreText
    )
  }
  
}
