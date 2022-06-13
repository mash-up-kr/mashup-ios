//
//  SignUpReactorSpec.swift
//  MashUp-iOSTests
//
//  Created by Booung on 2022/05/31.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import Mockingbird
import Nimble
import Quick
import RxBlocking
import RxSwift
@testable import MashUp_iOS
import MashUp_PlatformTeam
import Foundation

final class SignUpStep1ReactorSpec: QuickSpec {
  
  override func spec() {
    var sut: SignUpStep1Reactor!
    var verficationService: VerificationServiceMock!
    
    beforeEach {
      verficationService = mock(VerificationService.self)
      sut = SignUpStep1Reactor(verificationService: verficationService)
    }
    describe("회원가입 화면에서") {
      beforeEach {
        given(verficationService.verify(id: any()))
          .will { return $0 == "possible.id" }
        given(verficationService.verify(password: any()))
          .will { return $0 == "possible.password" }
      }
      
      context("id를 형식에 맞게 입력하지 않으면") {
        beforeEach {
          sut.action.onNext(.didEditIDField("impossible.id"))
        }
        it("id 필드에 부적격을 표시합니다.") {
          expect { sut.currentState.hasVaildatedID }.to(beFalse())
        }
      }
      
      context("비밀번호 를 형식에 맞게 입력하지 않으면") {
        beforeEach {
          sut.action.onNext(.didEditPasswordField("impossible.password"))
        }
        it("비밀번호 필드에 부적격을 표시합니다.") {
          expect { sut.currentState.hasVaildatedPassword }.to(beFalse())
        }
      }
      
      context("비밀번호 확인 필드가 포커스되면") {
        var hasScrolled: Observable<Void>!
        beforeEach {
          hasScrolled = sut.pulse(\.$shouldFocusPasswordCheckField).compactMap { $0 }.recorded()
          sut.action.onNext(.didFocusPasswordCheckField)
        }
        it("스크롤이 활성화됩니다") {
          expect { sut.currentState.canScroll }.to(beTrue())
        }
        it("비밀번호 확인 필드가 가려지지 않게 스크롤 됩니다") {
          expect { try! hasScrolled.toBlocking(timeout: 1).first() }.toNot(beNil())
        }
        
        context("비밀번호 확인 빌드가 포커스가 해제되면") {
          var hasScrolledToTop: Observable<Void>!
          beforeEach {
            hasScrolledToTop = sut.pulse(\.$shouldScrollToTop).compactMap { $0 }.recorded()
            sut.action.onNext(.didOutOfFocusPasswordCheckField)
          }
          it("스크롤이 비활성화됩니다") {
            expect { sut.currentState.canScroll }.to(beFalse())
          }
          it("맨위로 스크롤 됩니다") {
            expect { try! hasScrolledToTop.toBlocking(timeout: 1).first() }.toNot(beNil())
          }
        }
      }
      
      context("id / 비밀번호 / 비밀번호 확인 필드를 형식에 맞게 입력하면") {
        beforeEach {
          sut.action.onNext(.didEditIDField("possible.id"))
          sut.action.onNext(.didEditPasswordField("possible.password"))
          sut.action.onNext(.didEditPasswordCheckField("possible.password"))
        }
        it("다음 버튼이 활성화 됩니다") {
          expect { sut.currentState.canDone }.to(beTrue())
        }
        
        context("다음 버튼을 누르면") {
        }
      }
      
    }
  }
  
}
