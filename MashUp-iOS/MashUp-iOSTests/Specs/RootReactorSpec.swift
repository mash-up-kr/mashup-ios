//
//  RootReactorSpec.swift
//  MashUp-iOSTests
//
//  Created by Booung on 2022/02/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Mockingbird
import Nimble
import Quick
import RxBlocking
@testable import MashUp_iOS

final class RootReactorSpec: QuickSpec {
  override func spec() {
    var sut: RootReactor!
    
    beforeEach {
      sut = RootReactor()
    }
    context("앱 초기 진입시") {
      it("스플래시 화면을 표시합니다.") {
        sut.action.onNext(.didSetup)
        expect { sut.currentState.step }.to(equal(.splash))
      }
    }
    describe("authentication responder (root reactor)") {
      var userSessionStub: UserSession!
      context("스플래시 화면에서 자동 로그인에 성공하면") {
        beforeEach {
          userSessionStub = .stub(accessToken: "fake.access.token")
          sut.loadSuccess(userSession: userSessionStub)
        }
        it("홈 화면으로 이동합니다") {
          expect { sut.currentState.step }.to(equal(.home(userSessionStub)))
        }
      }
      context("스플래시 화면에서 자동로그인을 실패하면") {
        beforeEach {
          sut.loadFailure()
        }
        it("로그인 화면으로 이동합니다") {
          expect { sut.currentState.step }.to(equal(.signIn))
        }
      }
    }
  }
}
