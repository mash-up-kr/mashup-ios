//
//  SignUpCodeReactorSpec.swift
//  MashUp-iOSTests
//
//  Created by Booung on 2022/06/03.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import XCTest
import Quick
import Nimble
import Mockingbird
import MashUp_Auth
import MashUp_User
@testable import MashUp_SignUpCode

final class SignUpCodeReactorSpec: QuickSpec {
  
  override func spec() {
    var sut: SignUpCodeReactor!
    var signUpCodeVerificationService: SignUpCodeVerificationServiceMock!
    var userAuthService: UserAuthServiceMock!
    var authenticationResponder: AuthenticationResponderMock!
    
    describe("가입코드 입력화면에서") {
      beforeEach {
        signUpCodeVerificationService = mock(SignUpCodeVerificationService.self)
        userAuthService = mock(UserAuthService.self)
        authenticationResponder = mock(AuthenticationResponder.self)
        
        sut = SignUpCodeReactor(
          userInProgressOfSigningUp: NewAccount(
            id: "fake.id",
            password: "fake.password",
            name: "fake.name",
            platform: .iOS
          ),
          signUpCodeVerificationService: signUpCodeVerificationService,
          userAuthService: userAuthService,
          authenticationResponder: authenticationResponder
        )
      }
      
      context("코드가 5글자보다 짧은 코드를 입력하면") {
        beforeEach { sut.action.onNext(.didEditSignUpCodeField("1234")) }
        it("코드가 입력됩니다") {
          expect { sut.currentState.signUpCode }.to(equal("1234"))
        }
        it("'완료'버튼이 비활성화를 유지합니다") {
          expect { sut.currentState.canDone }.to(beFalse())
        }
      }
      
      context("코드가 5글자 코드를 입력하면") {
        beforeEach {
          sut.action.onNext(.didEditSignUpCodeField("12345"))
        }
        it("코드가 입력됩니다") {
          expect { sut.currentState.signUpCode }.to(equal("12345"))
        }
        it("'완료'버튼이 활성화 됩니다") {
          expect { sut.currentState.canDone }.to(beTrue())
        }
        
      }
      
      context("코드가 5글자보다 긴 코드를 입력하면") {
        beforeEach {
          sut.action.onNext(.didEditSignUpCodeField("123456"))
        }
        it("앞에 입력한 5코드만 입력됩니다") {
          expect { sut.currentState.signUpCode }.to(equal("12345"))
        }
        it("'완료'버튼이 비활성화를 유지합니다.") {
          expect { sut.currentState.canDone }.to(beTrue())
        }
      }
    }
  }
}
