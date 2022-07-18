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
        var shouldCloses: Observable<Void>!
        beforeEach {
          shouldCloses = sut.state.map { $0.shouldClose }.compactMap { $0 }.recorded()
        }
        it("화면이 닫힙니다") {
          let shouldClose: Void? = try! shouldCloses.toBlocking(timeout: 1.1).first()
          expect { shouldClose }.toNot(beNil())
        }
      }
    }
    
  }
  
}
