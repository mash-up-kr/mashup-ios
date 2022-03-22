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
      sut = SeminarDetailReactor(attendanceService: attendanceService)
    }
    
    describe("SeminarDetailReactor 멤버 로직") {
      var recorded: Observable<Bool>!
      beforeEach {
        recorded = sut.state.map { $0.isLoading }.distinctUntilChanged().take(3).recorded()
        given(attendanceService.attendanceMember(platform: any())).willReturn(.just(AttendanceMember.dummy))
      }
      context("when 플랫폼 라디오버튼 선택") {
        beforeEach {
          sut.action.onNext(.didSelectedPlatform(at: 1))
        }
        
        it("로딩 인디케이터 true 후 false") {
          let event = try recorded.toBlocking(timeout: 1).toArray()
          expect { event }.to(equal([false, true, false]))
        }
        
        it("멤버 교체") {
          expect { sut.currentState.members }.toNot(beEmpty())
        }
        
        it("선택된 인덱스 변경") {
          expect { sut.currentState.selectedPlatformIndex }.toNot(equal(0))
        }
        
        it("플랫폼에 해당하는 멤버 호출") {
          verify(attendanceService.attendanceMember(platform: .android)).wasCalled()
        }
      }
    }
  }
}
 
