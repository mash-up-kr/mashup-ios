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
import RxSwift
import RxBlocking

class MyPageReactorSpec: QuickSpec {
  
  override func spec() {
    var sut: MyPageReactor!
    let stubGeneration: Generation = Generation(number: 12)
    var stubUserSession: UserSession!
    var clubActivityService: ClubActivityServiceMock!
    var formatter: MyPageFormatterMock!
    var debugSystem: DebugSystemMock!
    
    beforeEach {
      stubUserSession = UserSession.stub(generations: [stubGeneration])
      clubActivityService = mock(ClubActivityService.self)
      formatter = mock(MyPageFormatter.self)
      debugSystem = mock(DebugSystem.self)
    }
    describe("마이페이지에서") {
      beforeEach {
        sut = MyPageReactor(
          userSession: stubUserSession,
          clubActivityService: clubActivityService,
          formatter: formatter,
          debugSystem: debugSystem
        )
      }
      
      context("화면이 준비되면") {
        var stubTotalScore: Int!
        var stubSummaryBar: MyPageSummaryBarModel!
        var stubHeader: MyPageHeaderViewModel!
        var stubHistories: [ClubActivityHistory]!
        var stubSections: [MyPageSection]!
        var recordedIsLoading: Observable<Bool>!
        beforeEach {
          stubTotalScore = 10
          stubSummaryBar = MyPageSummaryBarModel.stub()
          stubHeader = MyPageHeaderViewModel.stub()
          stubHistories = []
          stubSections = [
            .title(MyPageSection.TitleHeader(title: "stub.header")),
            .histories(MyPageSection.HistoryHeader(generationText: "12기"), items: [])
          ]
          givenSwift(clubActivityService.totalClubActivityScore()).willReturn(.just(stubTotalScore))
          givenSwift(clubActivityService.histories(generation: any())).willReturn(.just(stubHistories))
          givenSwift(formatter.formatHeader(userSession: stubUserSession, totalScore: 10)).willReturn(stubHeader)
          givenSwift(formatter.formatSections(with: any())).willReturn(stubSections)
          givenSwift(formatter.formatSummaryBar(userSession: stubUserSession, totalScore: 10)).willReturn(stubSummaryBar)
          
          recordedIsLoading = sut.state.map { $0.isLoading }.distinctUntilChanged().recorded()
          sut.action.onNext(.didSetup)
        }
        it("로딩 인디케이터가 표시되었다가 사라집니다") {
          let isLoadings = try! recordedIsLoading.take(3).toBlocking(timeout: 1).toArray()
          expect { isLoadings }.to(equal([false, true, false]))
        }
        it("유저의 총 활동 점수를 로드해옵니다") {
          verify(clubActivityService.totalClubActivityScore()).wasCalled()
        }
        it("최신 기수 유저 활동 히스토리 정보로 섹션을 포맷팅합니다") {
          verify(formatter.formatSections(with: any())).wasCalled()
        }
        it("유저활동 히스토리 섹션을 업데이트합니다.") {
          expect { sut.currentState.sections }.to(equal(stubSections))
        }
        it("로드해온 활동 점수로 상단바를 포맷팅합니다") {
          verify(formatter.formatSummaryBar(userSession: stubUserSession, totalScore: stubTotalScore)).wasCalled()
        }
        it("포맷팅된 데이터로 상단바를 업데이트합니다") {
          expect { sut.currentState.summaryBarModel }.to(equal(stubSummaryBar))
        }
        it("로드해온 활동 점수로 헤더를 포맷팅합니다") {
          verify(formatter.formatHeader(userSession: stubUserSession, totalScore: stubTotalScore)).wasCalled()
        }
        it("포맷팅된 데이터로 헤더를 업데이트합니다") {
          expect { sut.currentState.headerModel }.to(equal(stubHeader))
        }
        it("유저의 활동 히스토리를 로드해옵니다") {
          verify(clubActivityService.histories(generation: any())).wasCalled()
        }
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
