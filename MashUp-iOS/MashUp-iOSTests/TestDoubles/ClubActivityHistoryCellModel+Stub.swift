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
    historyTitle: String = "stub.history.title.\(UUID().uuidString)",
    description: String = "stub.description.\(UUID().uuidString)",
    scoreChangeStyle: ScoreChangeStyle = .custom(UUID().uuidString),
    appliedTotalScoreText: String = "stub.total.score.\(UUID().uuidString)"
  ) -> Self {
    return ClubActivityHistoryCellModel(
      historyTitle: historyTitle,
      description: description,
      scoreChangeStyle: scoreChangeStyle,
      appliedTotalScoreText: appliedTotalScoreText
    )
  }
  
}
