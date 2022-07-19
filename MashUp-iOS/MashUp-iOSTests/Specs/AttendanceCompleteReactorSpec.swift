//
//  AttendanceCompleteReactorSpec.swift
//  MashUp-iOSTests
//
//  Created by Booung on 2022/07/19.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Mockingbird
import Nimble
import Quick
import RxBlocking
import RxSwift
@testable import MashUp_iOS

final class AttendanceCompleteReactorSpec: QuickSpec {
  
  override func spec() {
    var sut: AttendanceCompleteReactor!
    
    beforeEach {
      sut = AttendanceCompleteReactor()
    }
    describe("출석 체크 완료화면은") {
      beforeEach {
        sut.action.onNext(.didSetup)
      }
      context("화면에 표시된 후 1초가 지나면") {
        var shouldClose: Void?
        beforeEach {
          shouldClose = try? sut.state.map { $0.shouldClose }
            .compactMap { $0 }
            .toBlocking(timeout: 1.0 + .tolerance)
            .first()
        }
        it("화면이 닫힙니다") {
          expect { shouldClose }.toNot(beNil())
        }
      }
    }
    
  }
  
}

extension TimeInterval {
  static let tolerance = 0.1
}
