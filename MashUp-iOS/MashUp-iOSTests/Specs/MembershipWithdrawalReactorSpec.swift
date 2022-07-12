//
//  MembershipWithdrawalReactorSpec.swift
//  MashUp-iOSTests
//
//  Created by 남수김 on 2022/07/08.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import Nimble
import Quick
import RxSwift
import Mockingbird
@testable import MashUp_iOS

final class MembershipWithdrawalReactorSpec: QuickSpec {
  override func spec() {
    var reactor: MembershipWithdrawalReactor!
    
    describe("MembershipWithdrawalReactor테스트") {
      beforeEach {
        let service = mock(MembershipWithdrawalService.self)
        reactor = MembershipWithdrawalReactor(service: service)
      }
      
      context("탈퇴할게요 문자열을 입력하면") {
        beforeEach {
          reactor.action.onNext(.didEditConfirmTextField("탈퇴할게요"))
        }
        it("유효하다") {
          expect { reactor.currentState.isValidated }.to(beTrue())
        }
      }
      
      context("다른 텍스트면 유효하지않다") {
        beforeEach {
          reactor.action.onNext(.didEditConfirmTextField("탈퇴할까요"))
        }
        it("유효하지않다") {
          expect { reactor.currentState.isValidated }.to(beFalse())
        }
      }
      
      context("회원탈퇴버튼을 누르면") {
        beforeEach {
          let service = mock(MembershipWithdrawalService.self)
          given(service.withdrawal()).willReturn(.just(true))
          reactor = MembershipWithdrawalReactor(service: service)
          
          reactor.action.onNext(.didTapWithdrawalButton)
        }
        it("회원탈퇴 통신성공") {
          expect { reactor.currentState.isWithdrawnOfMembership }.to(beTrue())
        }
      }
      
      context("회원탈퇴버튼을 누르면") {
        beforeEach {
          let service = mock(MembershipWithdrawalService.self)
          given(service.withdrawal()).willReturn(.just(false))
          reactor = MembershipWithdrawalReactor(service: service)
          
          reactor.action.onNext(.didTapWithdrawalButton)
        }
        it("회원탈퇴 통신실패") {
          expect { reactor.currentState.isWithdrawnOfMembership }.to(beFalse())
        }
      }
      
      let error: NSError = NSError(domain: "", code: 0)
      context("회원탈퇴버튼을 누르고 에러가 발생한다면") {
        beforeEach {
          let service = mock(MembershipWithdrawalService.self)
          given(service.withdrawal()).willReturn(.error(error))
          reactor = MembershipWithdrawalReactor(service: service)
          
          reactor.action.onNext(.didTapWithdrawalButton)
        }
        it("회원탈퇴 통신실패") {
          expect { reactor.currentState.isWithdrawnOfMembership }.to(beFalse())
        }
        it("에러 표시") {
          expect { reactor.currentState.error }.to(matchError(error))
        }
      }
    }
  }
}
