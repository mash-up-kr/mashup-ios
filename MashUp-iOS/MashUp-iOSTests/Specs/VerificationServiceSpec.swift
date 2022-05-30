//
//  VerificationServiceSpec.swift
//  MashUp-iOSTests
//
//  Created by Booung on 2022/05/30.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import Nimble
import Quick
@testable import MashUp_iOS

final class VerificationServiceSpec: QuickSpec {
  
  override func spec() {
    var sut: VerificationServiceImpl!
    beforeEach {
      sut = VerificationServiceImpl()
    }
    describe("회원정보를 검증할 때") {
      context("id는") {
        it("4글자 이상으로 구성됩니다") {
          let idLessThan4Characters = "ABC"
          expect(sut.verify(id: idLessThan4Characters)).to(beFalse())
          
          let idEqual4Characters = "ABCD"
          expect(sut.verify(id: idEqual4Characters)).to(beTrue())
        }
        it("15글자 이내으로 구성됩니다") {
          let idLessThan15Characters = "ABCEDFGHIJKLMN"
          expect(sut.verify(id: idLessThan15Characters)).to(beTrue())
          
          let idEqual15Characters = "ABCEDFGHIJKLMNO"
          expect(sut.verify(id: idEqual15Characters)).to(beTrue())
          
          let idGreaterThen15Characters = "ABCEDFGHIJKLMNOP"
          expect(sut.verify(id: idGreaterThen15Characters)).to(beFalse())
        }
        it("영어대소문자로만 구성됩니다") {
          let idConsistingOnlyOfAlphabets = "ABcdeF"
          expect(sut.verify(id: idConsistingOnlyOfAlphabets)).to(beTrue())
          
          let idWithSpeicalCharacters = "ABcdeF!"
          expect(sut.verify(id: idWithSpeicalCharacters)).to(beFalse())
          
          let idWithNumberCharacters = "ABcdeF1"
          expect(sut.verify(id: idWithNumberCharacters)).to(beFalse())
          
          let idWithHanguelCharacters = "ABcdeF1안녕"
          expect(sut.verify(id: idWithHanguelCharacters)).to(beFalse())
        }
      }
      context("password는") {
        it("8자 이상으로 구성됩니다") {
          let passwordLessThen8Characters = "qwer123"
          expect(sut.verify(password: passwordLessThen8Characters)).to(beFalse())
          
          let passwordEqual8Characters = "qwer1234"
          expect(sut.verify(password: passwordEqual8Characters)).to(beTrue())
          
          let passwordGreaterThen8Characters = "qwer12345"
          expect(sut.verify(password: passwordGreaterThen8Characters)).to(beTrue())
        }
        it("숫자와 알파벳을 모두 포함합니다") {
          let passwordConsistingOnlyOfNumberCharacters = "12345678"
          expect(sut.verify(password: passwordConsistingOnlyOfNumberCharacters)).to(beFalse())
          
          let passwordConsistingOnlyOfAlabets = "abcedfghi"
          expect(sut.verify(password: passwordConsistingOnlyOfAlabets)).to(beFalse())
          
          let passwordConsistingOfAlphanumericCharacters = "qwer1234"
          expect(sut.verify(password: passwordConsistingOfAlphanumericCharacters)).to(beTrue())
        }
      }
      context("name는") {
        it("2자 이상으로 구성됩니다") {
          let nameLessThen2Characters = "이"
          expect(sut.verify(name: nameLessThen2Characters)).to(beFalse())
          
          let nameEqual2Characters = "이동"
          expect(sut.verify(name: nameEqual2Characters)).to(beTrue())
          
          let nameGreaterThen2Characters = "이동영"
          expect(sut.verify(name: nameGreaterThen2Characters)).to(beTrue())
        }
      }
    }
  }
  
}
