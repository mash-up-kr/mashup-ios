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
    describe("action.didLoad") {
      var stubSession: UserSession!
      context("when occurs with user session") {
        beforeEach {
          stubSession = UserSession(accessToken: "fake.access.token")
          sut.action.onNext(.didLoad(stubSession))
        }
        it("present home screen with session") {
          expect { sut.currentState.step }.to(equal(.home(stubSession)))
        }
      }
      context("when occurs with nil session") {
        beforeEach {
          stubSession = nil
          sut.action.onNext(.didLoad(stubSession))
        }
        it("present sign in screen") {
          expect { sut.currentState.step }.to(equal(.signIn))
        }
      }
    }
  }
}
