//
//  PlatformAttendanceStatusReactorSpec.swift
//  MashUp-iOSTests
//
//  Created by 남수김 on 2022/05/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Mockingbird
import Nimble
import Quick
import RxSwift
import MashUp_PlatformTeam
import MashUp_Network
@testable import MashUp_iOS

final class PlatformAttendanceStatusReactorSpec: QuickSpec {
  override func spec() {
    var sut: PlatformAttendanceStatusReactor!
    var platformService: PlatformServiceMock!
    let scheduleID = 1
    
    describe("PlatformAttendanceStatusReactor 로직테스트") {
      beforeEach {
        platformService = mock(PlatformService.self)
        sut = PlatformAttendanceStatusReactor(platformService: platformService, scheduleID: scheduleID)
      }
      context("리스트에서 iOS클릭시") {
        beforeEach {
          sut.action.onNext(.didTapPlatform(.iOS))
        }
        it("현재선택플랫폼 iOS로 상태변경됩니다.") {
          expect { sut.currentState.selectedPlatform }.to(equal(.iOS))
        }
      }
      context("리스트에서 Android클릭시") {
        beforeEach {
          sut.action.onNext(.didTapPlatform(.android))
        }
        it("현재선택플랫폼 Android로 상태변경됩니다.") {
          expect { sut.currentState.selectedPlatform }.to(equal(.android))
        }
      }
      
      context("진입시 초기정보 셋팅을 하면") {
        beforeEach {
          given(platformService.attendanceStatus(scheduleID: scheduleID)).willReturn(.just(PlatformAttendanceStatusReactorSpec.mockPlatformResponse.asPlatformAttendance))
          sut.action.onNext(.didSetup)
        }
        
        it("통신모델을 도메인 모델로 변환시킵니다") {
          expect { PlatformAttendanceStatusReactorSpec.mockPlatformResponse.asPlatformAttendance }.to(equal(PlatformAttendanceStatusReactorSpec.expactPlatformAttendance))
        }
        it("생성시 넣어준 scheduleID을 가지고 있어야합니다.") {
          expect { sut.currentState.scheduleID == scheduleID }.to(beTrue())
        }
        it("scheduleID을 이용해서 전체 플랫폼의 출석현황에 대한 통신을 호출합니다.") {
          verify(platformService.attendanceStatus(scheduleID: scheduleID)).wasCalled()
        }
      }
    }
  }
}

extension PlatformAttendanceStatusReactorSpec {
  fileprivate static var mockPlatformResponse: PlatformAttendanceResponse {
    PlatformAttendanceResponse(
      isEnd: true,
      platformInfos: [
        .init(attendanceCount: 10, lateCount: 2, platform: "ios", totalCount: 20),
        .init(attendanceCount: 5, lateCount: 5, platform: "IOS", totalCount: 20)
      ]
    )
  }
  fileprivate static var expactPlatformAttendance: PlatformAttendance {
    PlatformAttendance(
      platformAttendanceInformations: [
        .init(platform: .iOS, numberOfAttend: 10, numberOfLateness: 2, numberOfAbsence: 8),
        .init(platform: .iOS, numberOfAttend: 5, numberOfLateness: 5, numberOfAbsence: 10)
      ],
      isAttending: true
    )
  }
}
