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
    describe("QRScanFormatter.formatTime(from:)") {
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
    
    describe("QRScanFormatter.formatTimeline(from:)") {
      let timeStampStub1 = Date(hour: 15, minute: 10, second: 10)
      let timeStampStub2 = Date(hour: 16, minute: 20, second: 10)
      let partialAttendanceStub1 = PartialAttendance.stub(timestamp: timeStampStub1)
      let partialAttendanceStub2 = PartialAttendance.stub(timestamp: timeStampStub2)
      let timelineStub = AttendanceTimeline(partialAttendance1: partialAttendanceStub1,
                                            partialAttendance2: partialAttendanceStub2)
      context("timeline을 포맷팅할 때") {
        var timeline: AttendanceTimelineViewModel!
        beforeEach {
          timeline = sut.formatTimeline(from: timelineStub)
        }
        it("1부 부분 출석의 timestamp를 hh:mm:ss 형태로 표시합니다") {
          expect { timeline.partialAttendance1.timestamp }.to(equal("03:10:10"))
        }
        it("2부 부분 출석의 timestamp를 hh:mm:ss 형태로 표시합니다") {
          expect { timeline.partialAttendance2.timestamp }.to(equal("04:20:10"))
        }
        it("최종 출석의 timestamp는 표시하지 않습니다") {
          expect { timeline.totalAttendance.timestamp }.to(beNil())
        }
      }
    }
}


