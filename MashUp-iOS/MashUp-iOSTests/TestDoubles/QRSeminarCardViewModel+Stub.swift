//
//  QRSeminarCardViewModel+Stub.swift
//  MashUp-iOSTests
//
//  Created by Booung on 2022/03/24.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
@testable import MashUp_iOS

extension QRSeminarCardViewModel {
  static func stub(
    title: String = "fake.title.\(Date.now())",
    dday: String = "fake.dday.\(Date.now())",
    date: String = "fake.date.\(Date.now())",
    time: String = "fake.time.\(Date.now())",
    timeline: AttendanceTimelineViewModel = .stub()
  ) -> QRSeminarCardViewModel {
    return QRSeminarCardViewModel(
      title: title,
      dday: dday,
      date: date,
      time: time,
      timeline: timeline
    )
  }
}
