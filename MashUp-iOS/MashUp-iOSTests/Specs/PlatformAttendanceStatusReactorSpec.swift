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
@testable import MashUp_iOS

final class PlatformAttendanceStatusReactorSpec: QuickSpec {
  override func spec() {
    var sut: PlatformAttendanceStatusReactor!
    var platformService: PlatformService!
    
    describe("PlatformAttendanceStatusReactor 로직") {
      beforeEach {
        let repository = mock(PlatformRepository.self)
        given(repository.attendanceStatus()).willReturn(.just(PlatformAttendanceStatusReactorSpec.platformDummy))
        platformService = PlatformServiceImpl(repository: repository)
        sut = PlatformAttendanceStatusReactor(platformService: platformService)
      }
      context("리스트에서 iOS클릭시") {
        beforeEach {
          sut.action.onNext(.didTapPlatform(.iOS))
        }
        it("현재선택플랫폼 iOS로 상태변경") {
          expect { sut.currentState.selectedPlatform }.to(equal(.iOS))
        }
      }
      context("리스트에서 Android클릭시") {
        beforeEach {
          sut.action.onNext(.didTapPlatform(.android))
        }
        it("현재선택플랫폼 Android로 상태변경") {
          expect { sut.currentState.selectedPlatform }.to(equal(.android))
        }
      }
      
      context("진입시 초기정보 가져오기") {
        beforeEach {
          sut.action.onNext(.didSetup)
        }
        it("통신호출") {
          verify(platformService.attendanceStatus()).wasCalled()
        }
        it("플랫폼 리스트 가져옴") {
          expect { sut.currentState.platformsAttendance }.to(equal(PlatformAttendanceStatusReactorSpec.platformDummy))
        }
      }
    }
  }
}

extension PlatformAttendanceStatusReactorSpec {
  fileprivate static let platformDummy: [PlatformAttendance]
  = [PlatformAttendance(platform: .iOS,
                        numberOfAttend: 10,
                        numberOfLateness: 0,
                        numberOfAbsence: 1)]
}
