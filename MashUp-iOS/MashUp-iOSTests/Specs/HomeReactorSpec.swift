//
//  HomeReactorSpec.swift
//  MashUp-iOSTests
//
//  Created by Booung on 2022/02/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Mockingbird
import Nimble
import Quick
@testable import MashUp_iOS

final class HomeReactorSpec: QuickSpec {
  override func spec() {
    var sut: HomeReactor!
    beforeEach {
      sut = HomeReactor()
    }
    describe("home tab bar") {
      context("초기 진입시") {
        it("세미나 스케줄을 표시합니다.") {
          expect { sut.currentState.currentTab }.to(equal(.seminarSchedule))
        }
      }
      context("1번 탭을 누르면") {
        beforeEach {
          sut.action.onNext(.didSelectTabItem(at: 0))
        }
        it("세미나 스케쥴 화면을 표시합니다.") {
          expect { sut.currentState.currentTab }.to(equal(.seminarSchedule))
        }
      }
      context("2번째 탭에 위치한 QR 버튼을 누르면") {
        beforeEach {
          sut.action.onNext(.didTapQRButton)
        }
        it("QR 화면을 표시합니다.") {
          expect { sut.currentState.step }.to(equal(.qr))
        }
      }
      
      context("2번 탭을 누르면") {
        beforeEach {
          sut.action.onNext(.didSelectTabItem(at: 1))
        }
        it("마이페이지 화면을 표시합니다.") {
          expect { sut.currentState.currentTab }.to(equal(.myPage))
        }
      }
      
    }
  }
}
