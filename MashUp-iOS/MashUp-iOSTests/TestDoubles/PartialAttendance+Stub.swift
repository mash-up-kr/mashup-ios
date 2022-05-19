//
//  PartialAttendance+Stub.swift
//  MashUp-iOSTests
//
//  Created by Booung on 2022/03/24.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
@testable import MashUp_iOS

extension PartialAttendance {
  static func stub(
    phase: SeminarPhase = .phase1,
    status: AttendanceStatus? = nil,
    timestamp: Date? = nil
  ) -> PartialAttendance {
    return PartialAttendance(phase: phase, status: status, timestamp: timestamp)
  }
}
