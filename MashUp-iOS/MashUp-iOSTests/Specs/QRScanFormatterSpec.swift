//
//  QRScanFormatterSpec.swift
//  MashUp-iOSTests
//
//  Created by Booung on 2022/03/24.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Mockingbird
import RxBlocking
@testable import MashUp_iOS

final class QRScanFormatterSpec: QuickSpec {
  
  override func spec() {
    var sut: QRScanFormatterImpl!
    
    beforeEach {
      sut = QRScanFormatterImpl()
    }
    describe("QRScanFormatter.formatTime(from:TimeInterval)") {
      context("0이하 초(TimeInterval)를") {
        it("nil로 표시합니다1") {
          let timeString = sut.formatTime(from: 0)
          expect { timeString }.to(beNil())
        }
        it("nil로 표시합니다2") {
          let timeString = sut.formatTime(from: -1)
          expect { timeString }.to(beNil())
        }
      }
      context("0~60초 사이의 초(TimeInterval)를") {
        it("00:ss 형태로 표시합니다 1") {
          let timeString = sut.formatTime(from: 01)
          expect { timeString }.to(equal("00:01"))
        }
        it("00:ss 형태로 표시합니다 2") {
          let timeString = sut.formatTime(from: 55)
          expect { timeString }.to(equal("00:55"))
        }
      }
      context("60초가 넘으면") {
        it("mm:ss 형태로 표시합니다 1") {
          let timeString = sut.formatTime(from: 360)
          expect { timeString }.to(equal("06:00"))
        }
        it("mm:ss 형태로 표시합니다 2") {
          let timeString = sut.formatTime(from: 720)
          expect { timeString }.to(equal("12:00"))
        }
      }
    }
    
}


