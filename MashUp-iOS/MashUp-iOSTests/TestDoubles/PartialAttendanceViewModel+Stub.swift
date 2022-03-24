//
//  PartialAttendanceViewModel+Stub.swift
//  MashUp-iOSTests
//
//  Created by Booung on 2022/03/24.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
@testable import MashUp_iOS

extension PartialAttendanceViewModel {
  static func stub(
    phase: SeminarPhase = .allCases.randomElement()!,
    timestamp: String = "fake.timestamp.\(Date.now())",
    style: AttendanceStyle = .allCases.randomElement()!
  ) -> PartialAttendanceViewModel {
    return PartialAttendanceViewModel(phase: phase, timestamp: timestamp, style: style)
  }
}
