//
//  AttendanceTimelineViewModel+Stub.swift
//  MashUp-iOSTests
//
//  Created by Booung on 2022/03/24.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
@testable import MashUp_iOS

extension AttendanceTimelineViewModel {
  
  static func stub(
    partialAttendance1: PartialAttendanceViewModel = .stub(),
    partialAttendance2: PartialAttendanceViewModel = .stub(),
    totalAttendance: PartialAttendanceViewModel = .stub()
  ) -> AttendanceTimelineViewModel {
    return AttendanceTimelineViewModel(
      partialAttendance1: partialAttendance1,
      partialAttendance2: partialAttendance2,
      totalAttendance: totalAttendance
    )
  }
}
