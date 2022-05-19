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
@testable import MashUp_iOS
import Foundation

final class SignInReactorSpec: QuickSpec {
  override func spec() {
    var sut: SignInReactor!
    var userSessionRepositoryMock: UserSessionRepositoryMock!
    var authenticationResponserMock: AuthenticationResponderMock!
    var disposeBag: DisposeBag!
    beforeEach {
      disposeBag = DisposeBag()
      userSessionRepositoryMock = mock(UserSessionRepository.self)
      authenticationResponserMock = mock(AuthenticationResponder.self)
      sut = SignInReactor(
        userSessionRepository: userSessionRepositoryMock,
        authenticationResponder: authenticationResponserMock
      )
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
      context("ID 텍스트 필드에 4글자보다 짧은 글자가 입력되어있다면") {
        beforeEach {
          let idShorterThan4 = "123"
          sut.action.onNext(.didEditIDField(idShorterThan4))
        }
        it("로그인 버튼이 비활성화 됩니다") {
          expect { sut.currentState.canTryToSignIn }.to(beFalse())
        }
      }
      context("PW 텍스트 필드에 4글자보다 짧은 글자가 입력되어있다면") {
        beforeEach {
          let passwordShorterThan4 = "123"
          sut.action.onNext(.didEditPasswordField(passwordShorterThan4))
        }
        it("로그인 버튼이 비활성화 됩니다") {
          expect { sut.currentState.canTryToSignIn }.to(beFalse())
        }
      }
      context("ID와 PW가 둘다 4글자가 넘으면") {
        beforeEach {
          let idLongerThan4 = "12345"
          let passwordLongerThan4 = "12345"
          sut.action.onNext(.didEditIDField(idLongerThan4))
          sut.action.onNext(.didEditPasswordField(passwordLongerThan4))
        }
        it("로그인 버튼이 활성화 됩니다") {
          expect { sut.currentState.canTryToSignIn }.to(beTrue())
        }
      }
    }
    
    describe("state.isLoading") {
      var testScheduler: TestScheduler!
      var isLoadingObserver: TestableObserver<Bool>!
      let correctID = "correct.id"
      let correctPassword = "correct.password"
      let stubedUserSession = UserSession.stub(accessToken: "fake.access.token")
      let error: Error = "sign in failure"
      beforeEach {
        testScheduler = TestScheduler(initialClock: 0)
        isLoadingObserver = testScheduler.createObserver(Bool.self)
        given(userSessionRepositoryMock.signIn(id: any(), password: any()))
          .willReturn(.error(error))
        given(userSessionRepositoryMock.signIn(id: correctID, password: correctPassword))
          .willReturn(.just(stubedUserSession))
      }
      context("로그인 버튼을 탭하면") {
        let idLongerThan4 = "12345"
        let passwordLongerThan4 = "12345"
        beforeEach {
          sut.state.map { $0.isLoading }
          .distinctUntilChanged()
          .observe(on: testScheduler)
          .subscribe(isLoadingObserver)
          .disposed(by: disposeBag)
          
          sut.action.onNext(.didEditIDField(idLongerThan4))
          sut.action.onNext(.didEditPasswordField(passwordLongerThan4))
          sut.action.onNext(.didTapSignInButton)
          
          testScheduler.start()
        }
        it("로딩 인디케이터가 표시되었다가 사라집니다.") {
          let isLoadings = isLoadingObserver.events.compactMap { $0.value.element }
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
        given(userSessionRepositoryMock.signIn(id: any(), password: any()))
          .willReturn(.error(error))
        given(userSessionRepositoryMock.signIn(id: correctID, password: correctPassword))
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
          expect { sut.currentState.step }.to(equal(.signUp))
        }
      }
    }
  }
}
