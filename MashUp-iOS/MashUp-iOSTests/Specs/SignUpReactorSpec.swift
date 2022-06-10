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

final class SignUpReactorSpec: QuickSpec {
  
  override func spec() {
    var sut: SignUpStep1Reactor!
    var verficationService: VerificationServiceMock!
    
    beforeEach {
      verficationService = mock(VerificationService.self)
      sut = SignUpStep1Reactor(verificationService: verficationService)
    }
    describe("회원가입 화면에서") {
//      let stubedPlatform: [PlatformTeam] = [.design, .iOS]
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
      
      context("password를 형식에 맞게 입력하지 않으면") {
        beforeEach {
          sut.action.onNext(.didEditPasswordField("impossible.password"))
        }
        it("password 필드에 부적격을 표시합니다.") {
          expect { sut.currentState.hasVaildatedPassword }.to(beFalse())
        }
      }
      
      context("id / pw / name 필드를 형식에 맞게 입력하면") {
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
        
//        context("플랫폼 선택 박스를 누르면") {
//          var shouldShowOnBottomSheetObserver: Observable<[PlatformTeam]>!
//          beforeEach {
//            shouldShowOnBottomSheetObserver = sut.state
//              .compactMap { $0.shouldShowOnBottomSheet }
//              .take(1)
//              .recorded()
//            sut.action.onNext(.didTapPlatformSelectControl)
//          }
//          it("로드해온 플랫폼 정보가 플랫폼 선택 바텀 시트가 노출됩니다.") {
//            let shouldShowOnBottomSheet = try! shouldShowOnBottomSheetObserver
//              .toBlocking(timeout: 1)
//              .first()
//            expect { shouldShowOnBottomSheet }.to(equal(stubedPlatform))
//          }
//
////          context("플랫폼 입력을 선택하면 완료되면") {
////            beforeEach {
////              sut.action.onNext(.didSelectPlatform(at: 0))
////            }
////            it("선택한 플랫폼이 노출됩니다.") {
////              expect { sut.currentState.selectedPlatform }.to(equal(stubedPlatform[0]))
////            }
////            it("다음 버튼이 활성화됩니다") {
////              expect { sut.currentState.canDone }.to(beTrue())
////            }
////
////            context("다음 버튼을 누르면 ") {
////              beforeEach {
////                sut.action.onNext(.didTapDoneButton)
////              }
////              it("약관 동의 여부를 표시합니다.") {
////                expect { sut.currentState.shouldShowPolicyAgreementStatus }.toNot(beNil())
////              }
////            }
////          }
//        }
      }
      
    }
  }
  
}
