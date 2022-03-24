//
//  AttendanceTimelineSpec.swift
//  MashUp-iOSTests
//
//  Created by Booung on 2022/03/24.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

import Mockingbird
import Nimble
import Quick
@testable import MashUp_iOS

final class AttendanceTimelineSpec: QuickSpec {
  
  override func spec() {
    var sut: AttendanceTimeline!
    
    describe("출석 타임라인의 최종 출석 상태") {
      var partialAttendance1: PartialAttendance!
      var partialAttendance2: PartialAttendance!
      
      context("1부가 '🔘 출석예정' 이면") {
        beforeEach {
          partialAttendance1 = .stub(phase: .phase1, status: nil)
        }
        context("2부가 '🔘 출석예정' 이면") {
          beforeEach {
            partialAttendance2 = .stub(phase: .phase2, status: nil)
            sut = AttendanceTimeline(partialAttendance1: partialAttendance1,
                                     partialAttendance2: partialAttendance2)
          }
          it("최종 - '🔘 출석예정' 으로 표시됩니다") {
            let status = sut.totalAttendance.status
            expect { status }.to(beNil())
          
          }
        }
      }
      
      context("1부가 '🟢 출석' 이고") {
        beforeEach {
          partialAttendance1 = .stub(phase: .phase1, status: .attend)
        }
        context("2부가 '🔘 출석예정' 이면") {
          beforeEach {
            partialAttendance2 = .stub(phase: .phase2, status: nil)
            sut = AttendanceTimeline(partialAttendance1: partialAttendance1,
                                     partialAttendance2: partialAttendance2)
          }
          it("최종 - '🔘 출석예정' 으로 표시됩니다") {
            let status = sut.totalAttendance.status
            expect { status }.to(beNil())
          }
        }
        context("2부가 '🟢 출석' 이면") {
          beforeEach {
            partialAttendance2 = .stub(phase: .phase2, status: .attend)
            sut = AttendanceTimeline(partialAttendance1: partialAttendance1,
                                     partialAttendance2: partialAttendance2)
          }
          it("최종 - '🟢 출석' 으로 표시됩니다") {
            let status = sut.totalAttendance.status
            expect { status }.to(equal(.attend))
          }
        }
        context("2부가 '🟠 지각' 이면") {
          beforeEach {
            partialAttendance2 = .stub(phase: .phase2, status: .lateness)
            sut = AttendanceTimeline(partialAttendance1: partialAttendance1,
                                     partialAttendance2: partialAttendance2)
          }
          it("최종 - '🔴 결석' 으로 표시됩니다") {
            let status = sut.totalAttendance.status
            expect { status }.to(equal(.absence))
          }
        }
        context("2부가 '🔴 결석' 이면") {
          beforeEach {
            partialAttendance2 = .stub(phase: .phase2, status: .absence)
            sut = AttendanceTimeline(partialAttendance1: partialAttendance1,
                                     partialAttendance2: partialAttendance2)
          }
          it("최종 - '🔴 결석' 으로 표시됩니다") {
            let status = sut.totalAttendance.status
            expect { status }.to(equal(.absence))
          }
        }
      }
      
      context("1부가 '🟠 지각' 이고") {
        beforeEach {
          partialAttendance1 = .stub(phase: .phase2, status: .lateness)
        }
        context("2부가 '🔘 출석예정' 이면") {
          beforeEach {
            partialAttendance2 = .stub(phase: .phase2, status: nil)
            sut = AttendanceTimeline(partialAttendance1: partialAttendance1,
                                     partialAttendance2: partialAttendance2)
          }
          it("최종 - '🔘 출석예정' 으로 표시됩니다") {
            let status = sut.totalAttendance.status
            expect { status }.to(beNil())
          }
        }
        context("2부가 '🟢 출석' 이면") {
          beforeEach {
            partialAttendance2 = .stub(phase: .phase2, status: .attend)
            sut = AttendanceTimeline(partialAttendance1: partialAttendance1,
                                     partialAttendance2: partialAttendance2)
          }
          it("최종 - '🟠 지각' 으로 표시됩니다") {
            let status = sut.totalAttendance.status
            expect { status }.to(equal(.lateness))
          }
        }
        context("2부가 '🟠 지각' 이면") {
          beforeEach {
            partialAttendance2 = .stub(phase: .phase2, status: .lateness)
            sut = AttendanceTimeline(partialAttendance1: partialAttendance1,
                                     partialAttendance2: partialAttendance2)
          }
          it("최종 - '🔴 결석' 으로 표시됩니다") {
            let status = sut.totalAttendance.status
            expect { status }.to(equal(.absence))
          }
        }
        context("2부가 '🔴 결석' 이면") {
          beforeEach {
            partialAttendance2 = .stub(phase: .phase2, status: .absence)
            sut = AttendanceTimeline(partialAttendance1: partialAttendance1,
                                     partialAttendance2: partialAttendance2)
          }
          it("최종 - '🔴 결석' 으로 표시됩니다") {
            let status = sut.totalAttendance.status
            expect { status }.to(equal(.absence))
          }
        }
      }
      
      context("1부가 '🔴 결석' 이고") {
        beforeEach {
          partialAttendance1 = .stub(phase: .phase2, status: .absence)
          sut = AttendanceTimeline(partialAttendance1: partialAttendance1,
                                   partialAttendance2: partialAttendance2)
        }
        context("2부가 '🔘 출석예정' 이면") {
          beforeEach {
            partialAttendance2 = .stub(phase: .phase2, status: nil)
            sut = AttendanceTimeline(partialAttendance1: partialAttendance1,
                                     partialAttendance2: partialAttendance2)
          }
          it("최종 - '🔘 출석예정' 으로 표시됩니다") {
            let status = sut.totalAttendance.status
            expect { status }.to(beNil())
          }
        }
        context("2부가 '🟢 출석' 이면") {
          beforeEach {
            partialAttendance2 = .stub(phase: .phase2, status: .attend)
            sut = AttendanceTimeline(partialAttendance1: partialAttendance1,
                                     partialAttendance2: partialAttendance2)
          }
          it("최종 - '🔴 결석' 으로 표시됩니다") {
            let status = sut.totalAttendance.status
            expect { status }.to(equal(.absence))
          }
        }
        context("2부가 '🟠 지각' 이면") {
          beforeEach {
            partialAttendance2 = .stub(phase: .phase2, status: .lateness)
            sut = AttendanceTimeline(partialAttendance1: partialAttendance1,
                                     partialAttendance2: partialAttendance2)
          }
          it("최종 - '🔴 결석' 으로 표시됩니다") {
            let status = sut.totalAttendance.status
            expect { status }.to(equal(.absence))
          }
        }
        context("2부가 '🔴 결석' 이면") {
          beforeEach {
            partialAttendance2 = .stub(phase: .phase2, status: .absence)
            sut = AttendanceTimeline(partialAttendance1: partialAttendance1,
                                     partialAttendance2: partialAttendance2)
          }
          it("최종 - '🔴 결석' 으로 표시됩니다") {
            let status = sut.totalAttendance.status
            expect { status }.to(equal(.absence))
          }
        }
      }
    }
  }
}
