//
//  AttendanceTimeline+Stub.swift
//  MashUp-iOSTests
//
//  Created by Booung on 2022/03/24.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
@testable import MashUp_iOS

extension AttendanceTimeline {
  static func stub(
    partialAttendance1: PartialAttendance? = nil,
    partialAttendance2: PartialAttendance? = nil
  ) -> AttendanceTimeline {
    return AttendanceTimeline(partialAttendance1: partialAttendance1,
                              partialAttendance2: partialAttendance2)
  }
}
