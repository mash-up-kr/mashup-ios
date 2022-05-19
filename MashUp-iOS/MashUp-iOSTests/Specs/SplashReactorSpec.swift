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
    var userSessionStub: UserSession!
    
    beforeEach {
      userSessionRepositoryMock = mock(UserSessionRepository.self)
      rootReactorMock = mock(AuthenticationResponder.self)
      sut = SplashReactor(userSessionRepository: userSessionRepositoryMock,
                          authenticationResponder: rootReactorMock)
    }
    context("저장소에서 유저 세션을 성공적으로 로드한다면") {
      beforeEach {
        userSessionStub = .stub(accessToken: "fake.user.session")
        given(userSessionRepositoryMock.load()).willReturn(.just(userSessionStub))
        sut.action.onNext(.didSetup)
      }
      it("성공을 알림과 함께 로드한 유저 세션을 RootReactor에게 전달합니다.") {
        verify(rootReactorMock.loadSuccess(userSession: userSessionStub)).wasCalled()
      }
    }
    context("저장소에서 유저 세션을 로드를 실패한다면") {
      beforeEach {
        userSessionStub = nil
        given(userSessionRepositoryMock.load()).willReturn(.just(userSessionStub))
        sut.action.onNext(.didSetup)
      }
      it("실패를 RootReactor에게 알립니다.") {
        verify(rootReactorMock.loadFailure()).wasCalled()
      }
    }
  }
  
}
