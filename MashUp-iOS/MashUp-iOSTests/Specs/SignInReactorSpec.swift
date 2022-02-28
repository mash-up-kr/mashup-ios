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
      context("when update id field's text") {
        let stubedID = "stubed.id"
        beforeEach {
          sut.action.onNext(.didEditIDField(stubedID))
        }
        it("is synchronized with updated id text") {
          expect { sut.currentState.id }.to(equal(stubedID))
        }
      }
    }
    describe("state.password") {
      context("when update password field's text") {
        let stubedPassword = "stubed.password"
        beforeEach {
          sut.action.onNext(.didEditPasswordField(stubedPassword))
        }
        it("is synchronized with updated password text") {
          expect { sut.currentState.password }.to(equal(stubedPassword))
        }
      }
    }
    describe("state.canTrySignIn") {
      context("when id are shorter than 4 chacters") {
        beforeEach {
          let idShorterThan4 = "123"
          sut.action.onNext(.didEditIDField(idShorterThan4))
        }
        it("is false") {
          expect { sut.currentState.canTryToSignIn }.to(beFalse())
        }
      }
      context("when password are shorter than 4 chacters") {
        beforeEach {
          let passwordShorterThan4 = "123"
          sut.action.onNext(.didEditPasswordField(passwordShorterThan4))
        }
        it("is false") {
          expect { sut.currentState.canTryToSignIn }.to(beFalse())
        }
      }
      context("when id & password are longer than 4 chacters") {
        beforeEach {
          let idLongerThan4 = "12345"
          let passwordLongerThan4 = "12345"
          sut.action.onNext(.didEditIDField(idLongerThan4))
          sut.action.onNext(.didEditPasswordField(passwordLongerThan4))
        }
        it("is true") {
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
      context("when tapped sign in button") {
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
        it("loading indicator appear and disappear") {
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
      context("when sign in success") {
        beforeEach {
          sut.action.onNext(.didEditIDField(correctID))
          sut.action.onNext(.didEditPasswordField(correctPassword))
          sut.action.onNext(.didTapSignInButton)
        }
        it("present home with user session") {
          verify(authenticationResponserMock.loadSuccess(userSession: userSessionStub)).wasCalled()
        }
      }
      context("when sign in failure") {
        beforeEach {
          sut.action.onNext(.didEditIDField(wrongID))
          sut.action.onNext(.didEditPasswordField(wrongPassword))
          sut.action.onNext(.didTapSignInButton)
        }
        it("show alert error message") {
          expect { sut.currentState.alertMessage }.to(equal(error.localizedDescription))
        }
      }
      context("when sign up button did tap") {
        beforeEach {
          sut.action.onNext(.didTapSignUpButton)
        }
        it("present sign up screen") {
          expect { sut.currentState.step }.to(equal(.signUp))
        }
      }
    }
  }
}
