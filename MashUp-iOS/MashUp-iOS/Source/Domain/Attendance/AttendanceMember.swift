//
//  AttendanceMember.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/03/17.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_PlatformTeam

struct AttendanceMember: Equatable {
    let name: String
    let firstSeminarAttendance: AttendanceStatus?
    let firstSeminarAttendanceTimeStamp: String?
    let secondSeminarAttendance: AttendanceStatus?
    let secondSeminarAttendanceTimeStamp: String?
}

extension AttendanceMember {
    static let dummy: [AttendanceMember] = [
        AttendanceMember(name: "김남수",
                         firstSeminarAttendance: .attend,
                         firstSeminarAttendanceTimeStamp: "13: 00",
                         secondSeminarAttendance: .attend,
                         secondSeminarAttendanceTimeStamp: "13: 30"),
        AttendanceMember(name: "김남수남",
                         firstSeminarAttendance: .lateness,
                         firstSeminarAttendanceTimeStamp: "13: 30",
                         secondSeminarAttendance: .attend,
                         secondSeminarAttendanceTimeStamp: "13: 50"),
        AttendanceMember(name: "남수남수김",
                         firstSeminarAttendance: .attend,
                         firstSeminarAttendanceTimeStamp: "12: 00",
                         secondSeminarAttendance: .absence,
                         secondSeminarAttendanceTimeStamp: nil),
    ]
    
    /// 출석 2개 = 출석
    /// 불참 1개이상포함 = 불참
    /// 지각 1개이상이면 = 지각
    var finalSeminarAttendance: AttendanceStatus? {
        var attendCount = 0
        var lateCount = 0
        var absenceCount = 0
        guard let firstSeminarAttendance = firstSeminarAttendance,
              let secondSeminarAttendance = secondSeminarAttendance else {
            return nil
        }
        switch firstSeminarAttendance {
        case .attend: attendCount += 1
        case .lateness: lateCount += 1
        case .absence: absenceCount += 1
        }
        
        switch secondSeminarAttendance {
        case .attend: attendCount += 1
        case .lateness: lateCount += 1
        case .absence: absenceCount += 1
        }
        
        if attendCount == 2 {
            return .attend
        }
        if absenceCount >= 1 {
            return .absence
        }
        if lateCount >= 1 {
            return .lateness
        }
        return nil
    }
}
