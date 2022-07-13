//
//  SignInReactorSpec.swift
//  MashUp-iOSTests
//
//  Created by Booung on 2022/02/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Mockingbird
import Nimble
import Quick
import RxBlocking
import RxSwift
import RxTest
import MashUp_Auth
import MashUp_User
@testable import MashUp_iOS
import Foundation

final class SignInReactorSpec: QuickSpec {
  
  override func spec() {
    var sut: SignInReactor!
    var userAuthServiceMock: UserAuthServiceMock!
    var verificationServiceMock: VerificationServiceMock!
    var authenticationResponserMock: AuthenticationResponderMock!
    
    beforeEach {
      userAuthServiceMock = mock(UserAuthService.self)
      verificationServiceMock = mock(VerificationService.self)
      authenticationResponserMock = mock(AuthenticationResponder.self)
      sut = SignInReactor(
        userAuthService: userAuthServiceMock,
        verificationService: verificationServiceMock,
        authenticationResponder: authenticationResponserMock
      )
      given(verificationServiceMock.verify(id: any())).will { return $0 == "correct.id" }
      given(verificationServiceMock.verify(password: any())).will { return $0 == "correct.password" }
    }
    describe("state.id") {
      context("ID 텍스트 필드가 업데이트 되면") {
        let stubedID = "stubed.id"
        beforeEach {
          sut.action.onNext(.didEditIDField(stubedID))
        }
        it("화면의 ID 상태도 업데이트됩니다.") {
          expect { sut.currentState.id }.to(equal(stubedID))
        }
      }
    }
    describe("state.password") {
      context("PW 텍스트 필드가 업데이트 되면") {
        let stubedPassword = "stubed.password"
        beforeEach {
          sut.action.onNext(.didEditPasswordField(stubedPassword))
        }
        it("화면의 PW 상태도 업데이트됩니다.") {
          expect { sut.currentState.password }.to(equal(stubedPassword))
        }
      }
    }
    describe("state.canTrySignIn") {
      context("ID PW가 둘다 검증되면") {
        beforeEach {
          sut.action.onNext(.didEditIDField("correct.id"))
          sut.action.onNext(.didEditPasswordField("correct.password"))
        }
        it("로그인 버튼이 활성화 됩니다") {
          expect { sut.currentState.canTryToSignIn }.to(beTrue())
        }
      }
    }
    
    describe("state.isLoading") {
      var isLoading: Observable<Bool>!
      let correctID = "correct.id"
      let correctPassword = "correct.password"
      let stubedUserSession = UserSession.stub(accessToken: "fake.access.token")
      let error: Error = "sign in failure"
      beforeEach {
        given(userAuthServiceMock.signIn(id: any(), password: any()))
          .willReturn(.error(error))
        given(userAuthServiceMock.signIn(id: correctID, password: correctPassword))
          .willReturn(.just(stubedUserSession))
      }
      context("로그인 버튼을 탭하면") {
        let idLongerThan4 = "12345"
        let passwordLongerThan4 = "12345"
        beforeEach {
          isLoading = sut.state.map { $0.isLoading }.distinctUntilChanged().take(3).recorded()
          
          sut.action.onNext(.didEditIDField(idLongerThan4))
          sut.action.onNext(.didEditPasswordField(passwordLongerThan4))
          sut.action.onNext(.didTapSignInButton)
        }
        it("로딩 인디케이터가 표시되었다가 사라집니다.") {
          let isLoadings = try isLoading.toBlocking().toArray()
          expect { isLoadings }.to(equal([false, true, false]))
        }
      }
    }
    
    describe("state.step") {
      let correctID = "correct.id"
      let correctPassword = "correct.password"
      let wrongID = "wrong.id"
      let wrongPassword = "wrong.password"
      let userSessionStub = UserSession.stub(accessToken: "fake.access.token")
      let error: Error = "sign in failure"
      beforeEach {
        given(userAuthServiceMock.signIn(id: any(), password: any()))
          .willReturn(.error(error))
        given(userAuthServiceMock.signIn(id: correctID, password: correctPassword))
          .willReturn(.just(userSessionStub))
      }
      context("로그인을 성공하면") {
        beforeEach {
          sut.action.onNext(.didEditIDField(correctID))
          sut.action.onNext(.didEditPasswordField(correctPassword))
          sut.action.onNext(.didTapSignInButton)
        }
        it("홈화면으로 이동합니다") {
          verify(authenticationResponserMock.loadSuccess(userSession: userSessionStub)).wasCalled()
        }
      }
      context("로그인을 실패하면") {
        beforeEach {
          sut.action.onNext(.didEditIDField(wrongID))
          sut.action.onNext(.didEditPasswordField(wrongPassword))
          sut.action.onNext(.didTapSignInButton)
        }
        it("에러 메시지를 표시합니다.") {
          expect { sut.currentState.alertMessage }.to(equal(error.localizedDescription))
        }
      }
      context("회원가입 버튼을 탭하면") {
        beforeEach {
          sut.action.onNext(.didTapSignUpButton)
        }
        it("회원가입 화면으로 이동합니다") {
          expect { sut.currentState.step }.to(equal(.signUp(authenticationResponserMock)))
        }
      }
    }
  }
}
