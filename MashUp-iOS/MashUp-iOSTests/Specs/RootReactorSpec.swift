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
    describe("action.didSetup") {
      context("when occurs") {
        beforeEach {
          sut.action.onNext(.didSetup)
        }
        it("present splash screen") {
          expect { sut.currentState.step }.to(equal(.splash))
        }
      }
    }
    describe("authentication responder (root reactor)") {
      var userSessionStub: UserSession!
      context("when load success user session by splash reactor") {
        beforeEach {
          userSessionStub = .stub(accessToken: "fake.access.token")
          sut.loadSuccess(userSession: userSessionStub)
        }
        it("present home screen with loaded user session") {
          expect { sut.currentState.step }.to(equal(.home(userSessionStub)))
        }
      }
      context("when load failure user session by splash reactor") {
        beforeEach {
          sut.loadFailure()
        }
        it("present sign in screen") {
          expect { sut.currentState.step }.to(equal(.signIn))
        }
      }
    }
  }
}
