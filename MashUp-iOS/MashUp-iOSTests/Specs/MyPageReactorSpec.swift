//
//  MyPageReactorSpec.swift
//  MashUp-iOSTests
//
//  Created by Booung on 2022/06/25.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
@testable import MashUp_User
@testable import MashUp_iOS
import Mockingbird
import Nimble
import Quick

class MyPageReactorSpec: QuickSpec {
  
  override func spec() {
    var sut: MyPageReactor!
    var userSession: UserSession!
    var clubActivityService: ClubActivityServiceMock!
    var debugSystem: DebugSystemMock!
    beforeEach {
      userSession = UserSession.stub()
      clubActivityService = mock(ClubActivityService.self)
      debugSystem = mock(DebugSystem.self)
    }
    describe("마이페이지에서") {
      beforeEach {
        sut = MyPageReactor(
          userSession: userSession,
          clubActivityService: clubActivityService,
          debugSystem: debugSystem
        )
      }
      
      context("메숑 마스코트를 5번 탭하면") {
        beforeEach {
          sut.action.onNext(.didTap5TimesMascot)
        }
        it("디버그 인디케이터가 동작합니다") {
          verify(debugSystem.on()).wasCalled()
        }
      }
      
      context("마이페이지 헤더뷰가 사라지면") {
        beforeEach {
          sut.action.onNext(.didDisappearHeaderView)
        }
        it("상단 메뉴바가 표시됩니다") {
          expect { sut.currentState.summaryBarHasVisable }.to(beTrue())
        }
    
        context("마이페이지 헤더뷰가 다시 보여지면") {
          beforeEach {
            sut.action.onNext(.didAppearHeaderView)
          }
          it("상단 메뉴바가 사라집니다") {
            expect { sut.currentState.summaryBarHasVisable }.to(beFalse())
          }
        }
      }
      
      context("헤더의 '❔'버튼을 클릭하면") {
        beforeEach {
          sut.action.onNext(.didTapQuestMarkButton)
        }
        it("출석점수정책 화면으로 이동합니다") {
          expect { sut.currentState.step }.to(equal(.clubActivityScoreRule))
        }
      }
      
      context("헤더의 설정버튼을 클릭하면") {
        beforeEach {
          sut.action.onNext(.didTapSettingButton)
        }
        it("설정 화면으로 이동합니다") {
          expect { sut.currentState.step }.to(equal(.setting))
        }
      }
      
    }
  }
  
}
