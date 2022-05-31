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

final class SeminarDetailReactorSpec: QuickSpec {
  override func spec() {
    var sut: SeminarDetailReactor!
    var attendanceService: AttendanceServiceMock!
    
    beforeEach {
      attendanceService = mock(AttendanceService.self)
    }
    describe("SeminarDetailReactor로직") {
      beforeEach {
        given(attendanceService.attendanceMembers(platform: any())).willReturn(.just(AttendanceMember.dummy))
        given(attendanceService.attendanceMembers(platform: .android)).willReturn(.just(SeminarDetailReactorSpec.androidMemberDummy))
        given(attendanceService.attendanceMembers(platform: .iOS)).willReturn(.just(SeminarDetailReactorSpec.iOSMemberDummy))
      }
      
      context("아오스 팀원리스트") {
        var recorded: Observable<Bool>!
        beforeEach {
          sut = SeminarDetailReactor(attendanceService: attendanceService, platform: .iOS)
          recorded = sut.state.map { $0.isLoading }.distinctUntilChanged().recorded().take(3)
          sut.action.onNext(.didSetup)
        }
        it("로딩 인디케이터 true 후 false") {
          let event = try recorded.toBlocking(timeout: 1).toArray()
          expect { event }.to(equal([false, true, false]))
        }
        it("아오스 팀원만 나와야함") {
          expect { sut.currentState.members }.to(equal(SeminarDetailReactorSpec.iOSMemberDummy))
        }
      }
      context("안드 팀원리스트") {
        beforeEach {
          sut = SeminarDetailReactor(attendanceService: attendanceService, platform: .android)
          sut.action.onNext(.didSetup)
        }
        it("아오스 팀원만 나와야함") {
          expect { sut.currentState.members }.to(equal(SeminarDetailReactorSpec.androidMemberDummy))
        }
      }
    }
  }
}
 
extension SeminarDetailReactorSpec {
  fileprivate static let androidMemberDummy: [AttendanceMember]
  = [AttendanceMember(name: "김남수",
                      platform: .android,
                      firstSeminarAttendance: .attend,
                      firstSeminarAttendanceTime: Date(),
                      secondSeminarAttendance: .attend,
                      secondSeminarAttendanceTime: Date()),
     AttendanceMember(name: "김남수1",
                      platform: .android,
                      firstSeminarAttendance: .attend,
                      firstSeminarAttendanceTime: Date(),
                      secondSeminarAttendance: .attend,
                      secondSeminarAttendanceTime: Date())]
  fileprivate static let iOSMemberDummy: [AttendanceMember]
  = [AttendanceMember(name: "김남수",
                      platform: .iOS,
                      firstSeminarAttendance: .attend,
                      firstSeminarAttendanceTime: Date(),
                      secondSeminarAttendance: .attend,
                      secondSeminarAttendanceTime: Date()),
     AttendanceMember(name: "김남수1",
                      platform: .iOS,
                      firstSeminarAttendance: .attend,
                      firstSeminarAttendanceTime: Date(),
                      secondSeminarAttendance: .attend,
                      secondSeminarAttendanceTime: Date())]
}
