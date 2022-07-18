//
//  SettingReactorSpec.swift
//  MashUp-iOSTests
//
//  Created by Booung on 2022/07/18.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

@testable import MashUp_iOS
@testable import MashUp_Auth
import Quick
import Mockingbird
import Nimble

final class SettingReactorSpec: QuickSpec {
  
  override func spec() {
    super.spec()
    
    var userAuthServiceMock: UserAuthServiceMock!
    var authenticationResponderMock: AuthenticationResponderMock!
    var sut: SettingReactor!
    
    beforeEach {
      userAuthServiceMock = mock(UserAuthService.self)
      authenticationResponderMock = mock(AuthenticationResponder.self)
      sut = SettingReactor(
        userAuthService: userAuthServiceMock,
        authenticationResponder: authenticationResponderMock
      )
    }
    
    describe("설정화면에서") {
      
      context("'로그아웃' 버튼을 누르면") {
        beforeEach {
          sut.action.onNext(.didTapSignOut)
          given(userAuthServiceMock.signOut()).willReturn(.just(true))
        }
        
        it("로그아웃 할 지 재확인 합니다") {
          expect { sut.currentState.askUserToSignOut }.toNot(beNil())
        }
        
        context("'확인'을 누르면") {
          beforeEach {
            sut.action.onNext(.didConfirmSignOut)
          }
          
          it("로그아웃 됩니다") {
            verify(userAuthServiceMock.signOut()).wasCalled()
          }
          
          it("홈화면으로 이동합니다") {
            verify(authenticationResponderMock.loadFailure()).wasCalled()
          }
        }
      }
      
      context("'회원탈퇴'버튼을 누르면") {
        beforeEach {
          sut.action.onNext(.didTapWithdrawal)
        }
        
        it("회원 탈퇴 화면으로 이동합니다") {
          expect { sut.currentState.step }.to(equal(.withdrawal))
        }
      }
      
      context("'페이스북'버튼을 누르면") {
        beforeEach {
          sut.action.onNext(.didTapFacebook)
        }
        
        it("페이스북 화면으로 이동합니다") {
          let facebookURL = URL(string: "https://www.facebook.com")!
          expect { sut.currentState.step }.to(equal(.open(facebookURL)))
        }
      }
      
      context("'인스타그램'버튼을 누르면") {
        beforeEach {
          sut.action.onNext(.didTapInstagram)
        }
        
        it("인스타그램 화면으로 이동합니다") {
          let instagramURL = URL(string: "https://www.instagram.com")!
          expect { sut.currentState.step }.to(equal(.open(instagramURL)))
        }
      }
      
      context("'티스토리'버튼을 누르면") {
        beforeEach {
          sut.action.onNext(.didTapTistory)
        }
        
        it("티스토리 화면으로 이동합니다") {
          let tistoryURL = URL(string: "https://www.tistory.com")!
          expect { sut.currentState.step }.to(equal(.open(tistoryURL)))
        }
      }
      
      context("'유투브'버튼을 누르면") {
        beforeEach {
          sut.action.onNext(.didTapYoutube)
        }
        
        it("유투브 화면으로 이동합니다") {
          let youtubeURL = URL(string: "https://www.youtube.com")!
          expect { sut.currentState.step }.to(equal(.open(youtubeURL)))
        }
      }
      
      context("'공식홈페이지'버튼을 누르면") {
        beforeEach {
          sut.action.onNext(.didTapHomepage)
        }
        
        it("공식홈페이지 웹으로 이동합니다") {
          let webPageURL = URL(string: "https://mash-up.kr")!
          expect { sut.currentState.step }.to(equal(.open(webPageURL)))
        }
      }
      
      context("'Recruit'버튼을 누르면") {
        beforeEach {
          sut.action.onNext(.didTapRecruit)
        }
        
        it("Recruit 웹으로  이동합니다") {
          let recruitURL = URL(string: "https://recruit.mash-up.kr")!
          expect { sut.currentState.step }.to(equal(.open(recruitURL)))
        }
      }
      
      context("'뒤로가기'버튼을 누르면") {
        beforeEach {
          sut.action.onNext(.didTapBack)
        }
        
        it("이전 화면으로 돌아갑니다") {
          expect { sut.currentState.shouldGoBackward }.toNot(beNil())
        }
      }
      
    }
  }
  
}
