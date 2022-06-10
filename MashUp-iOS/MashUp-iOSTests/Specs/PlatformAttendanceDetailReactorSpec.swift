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
      given(attendanceService.attendanceMembers(platform: .iOS)).willReturn(.just(AttendanceMember.dummy))
    }
    
    describe("멤버출석 현황") {
      context("iOS 초기진입시") {
        beforeEach {
          sut = PlatformAttendanceDetailReactor(attendanceService: attendanceService, platform: .iOS)
          sut.action.onNext(.didSetup)
        }
        it("현재플랫폼 상태는 iOS입니다.") {
          expect { sut.currentState.platform == .iOS }.to(beTrue())
        }
        it("멤버리스트가 나타난다") {
          expect { sut.currentState.members == AttendanceMember.dummy }.to(beTrue())
        }
      }
    }
  }
}

