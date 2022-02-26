//
//  SplashReactorSpec.swift
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

final class SplashReactorSpec: QuickSpec {
  override func spec() {
    var sut: SplashReactor!
    var userSessionRepositoryMock: UserSessionRepositoryMock!
    var rootReactorMock: AuthenticationResponderMock!
    
    beforeEach {
      userSessionRepositoryMock = mock(UserSessionRepository.self)
      rootReactorMock = mock(AuthenticationResponder.self)
      sut = SplashReactor(userSessionRepository: userSessionRepositoryMock,
                          authenticationResponder: rootReactorMock)
    }
    describe("") {
      var stubedUserSession: UserSession!
      context("when user session load success") {
        beforeEach {
          stubedUserSession = .stub(accessToken: "fake.user.session")
          given(userSessionRepositoryMock.load()).willReturn(.just(stubedUserSession))
          sut.action.onNext(.didSetup)
        }
        it("tell the root reactor that successful load with loaded session") {
          verify(rootReactorMock.loadSuccess(userSession: stubedUserSession)).wasCalled()
        }
      }
      context("when user session load failure") {
        beforeEach {
          stubedUserSession = nil
          given(userSessionRepositoryMock.load()).willReturn(.just(nil))
          sut.action.onNext(.didSetup)
        }
        it("tell root reactor that load failed ") {
          verify(rootReactorMock.loadFailure()).wasCalled()
        }
      }
    }
  }
}
