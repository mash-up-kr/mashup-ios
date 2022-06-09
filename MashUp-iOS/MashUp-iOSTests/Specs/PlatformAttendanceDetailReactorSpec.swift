//
//  SeminarDetailReactorSpec.swift
//  MashUp-iOSTests
//
//  Created by 남수김 on 2022/03/22.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Mockingbird
import Nimble
import Quick
import RxSwift
@testable import MashUp_iOS

final class PlatformAttendanceDetailReactorSpec: QuickSpec {
  override func spec() {
    var sut: PlatformAttendanceDetailReactor!
    var attendanceService: AttendanceServiceMock!
    
    beforeEach {
      attendanceService = mock(AttendanceService.self)
    }
  }
}

