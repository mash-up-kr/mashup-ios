//
//  AttendanceStatusCircleViewModelSpec.swift
//  MashUp-iOSTests
//
//  Created by 남수김 on 2022/06/10.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import Nimble
import Quick
import RxSwift
@testable import MashUp_iOS

final class AttendanceMemberSpec: QuickSpec {
  
  override func spec() {
    var sut: AttendanceMember!
    
    describe("멤버별 출석상태") {
      context("초기상태") {
        beforeEach {
          sut = AttendanceMember(name: "김남수",
                                 firstSeminarAttendance: nil,
                                 firstSeminarAttendanceTimeStamp: nil,
                                 secondSeminarAttendance: nil,
                                 secondSeminarAttendanceTimeStamp: nil)
        }
        it("초기상태 최종은 nil") {
          expect { sut.finalSeminarAttendance }.to(beNil())
        }
      }
      
      context("1부가 🟢출석") {
        context("2부가 🟢출석") {
          beforeEach {
            sut = AttendanceMember(name: "김남수",
                                   firstSeminarAttendance: .attend,
                                   firstSeminarAttendanceTimeStamp: "12:00",
                                   secondSeminarAttendance: .attend,
                                   secondSeminarAttendanceTimeStamp: "13:00")
          }
          it("최종은 🟢출석") {
            expect { sut.finalSeminarAttendance == .attend}.to(beTrue())
          }
        }
        
        context("2부가 🟡지각") {
          beforeEach {
            sut = AttendanceMember(name: "김남수",
                                   firstSeminarAttendance: .attend,
                                   firstSeminarAttendanceTimeStamp: "12:00",
                                   secondSeminarAttendance: .lateness,
                                   secondSeminarAttendanceTimeStamp: "13:00")
          }
          it("최종은 🟡지각") {
            expect { sut.finalSeminarAttendance == .lateness}.to(beTrue())
          }
        }
        
        context("2부가 🔴결석") {
          beforeEach {
            sut = AttendanceMember(name: "김남수",
                                   firstSeminarAttendance: .attend,
                                   firstSeminarAttendanceTimeStamp: "12:00",
                                   secondSeminarAttendance: .absence,
                                   secondSeminarAttendanceTimeStamp: nil)
          }
          it("최종은 🔴결석") {
            expect { sut.finalSeminarAttendance == .absence}.to(beTrue())
          }
        }
      }
      
      context("1부가 🟡지각") {
        context("2부가 🟢출석") {
          beforeEach {
            sut = AttendanceMember(name: "김남수",
                                   firstSeminarAttendance: .lateness,
                                   firstSeminarAttendanceTimeStamp: "12:00",
                                   secondSeminarAttendance: .attend,
                                   secondSeminarAttendanceTimeStamp: "13:00")
          }
          it("최종은 🟡지각") {
            expect { sut.finalSeminarAttendance == .lateness}.to(beTrue())
          }
        }
        
        context("2부가 🟡지각") {
          beforeEach {
            sut = AttendanceMember(name: "김남수",
                                   firstSeminarAttendance: .lateness,
                                   firstSeminarAttendanceTimeStamp: "12:00",
                                   secondSeminarAttendance: .lateness,
                                   secondSeminarAttendanceTimeStamp: "13:00")
          }
          it("최종은 🟡지각") {
            expect { sut.finalSeminarAttendance == .lateness}.to(beTrue())
          }
        }
        
        context("2부가 🔴결석") {
          beforeEach {
            sut = AttendanceMember(name: "김남수",
                                   firstSeminarAttendance: .lateness,
                                   firstSeminarAttendanceTimeStamp: "12:00",
                                   secondSeminarAttendance: .absence,
                                   secondSeminarAttendanceTimeStamp: nil)
          }
          it("최종은 🔴결석") {
            expect { sut.finalSeminarAttendance == .absence}.to(beTrue())
          }
        }
      }
      
      context("1부가 🔴결석") {
        context("2부가 🟢출석") {
          beforeEach {
            sut = AttendanceMember(name: "김남수",
                                   firstSeminarAttendance: .absence,
                                   firstSeminarAttendanceTimeStamp: nil,
                                   secondSeminarAttendance: .attend,
                                   secondSeminarAttendanceTimeStamp: "13:00")
          }
          it("최종은 🔴결석") {
            expect { sut.finalSeminarAttendance == .absence}.to(beTrue())
          }
        }
        
        context("2부가 🟡지각") {
          beforeEach {
            sut = AttendanceMember(name: "김남수",
                                   firstSeminarAttendance: .absence,
                                   firstSeminarAttendanceTimeStamp: nil,
                                   secondSeminarAttendance: .lateness,
                                   secondSeminarAttendanceTimeStamp: "13:00")
          }
          it("최종은 🔴결석") {
            expect { sut.finalSeminarAttendance == .absence}.to(beTrue())
          }
        }
        
        context("2부가 🔴결석") {
          beforeEach {
            sut = AttendanceMember(name: "김남수",
                                   firstSeminarAttendance: .absence,
                                   firstSeminarAttendanceTimeStamp: nil,
                                   secondSeminarAttendance: .absence,
                                   secondSeminarAttendanceTimeStamp: nil)
          }
          it("최종은 🔴결석") {
            expect { sut.finalSeminarAttendance == .absence}.to(beTrue())
          }
        }
      }
    }
  }
}
