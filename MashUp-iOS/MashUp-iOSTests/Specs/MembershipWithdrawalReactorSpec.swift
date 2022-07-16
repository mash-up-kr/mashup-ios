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
    var service: MembershipWithdrawalServiceMock!
    
    describe("MembershipWithdrawalReactor테스트") {
      beforeEach {
        service = mock(MembershipWithdrawalService.self)
        reactor = MembershipWithdrawalReactor(service: service)
      }
      
      context("회원탈퇴 화면에서 `탈퇴할게요` 문자열을 정확히 입력하면 ") {
        beforeEach {
          given(service.withdrawal()).willReturn(.just(Bool.random()))
          reactor.action.onNext(.didEditConfirmTextField("탈퇴할게요"))
        }
        it("유효한 상태의 텍스트필드와 회원탈퇴 버튼이 활성화됩니다.") {
          expect { reactor.currentState.isValidated }.to(beTrue())
        }
        
        context("회원탈퇴 버튼을 누르고 에러가 없다면") {
          beforeEach {
            reactor.action.onNext(.didTapWithdrawalButton)
          }
          it("회원탈퇴 통신성공 혹은 실패가 발생합니다.") {
            expect { reactor.currentState.isWithdrawnOfMembership }.toNot(beNil())
          }
        }
        
        context("회원탈퇴 버튼을 누르고 에러가 발생한다면") {
          let error: NSError = NSError(domain: "", code: 0)
          beforeEach {
            given(service.withdrawal()).willReturn(.error(error))
            reactor.action.onNext(.didTapWithdrawalButton)
          }
          it("회원탈퇴에 실패합니다.") {
            expect { reactor.currentState.isWithdrawnOfMembership }.to(beFalse())
          }
          it("에러 표시가 나타납니다.") {
            expect { reactor.currentState.error }.to(matchError(error))
          }
        }
      }
      
      context("정확한 텍스트가 아니면") {
        beforeEach {
          reactor.action.onNext(.didEditConfirmTextField("탈퇴할까요"))
        }
        it("유효하지않은 상태의 텍스트필드와 회원탈퇴 버튼이 비활성화 됩니다.") {
          expect { reactor.currentState.isValidated }.to(beFalse())
        }
      }
    }
  }
}
