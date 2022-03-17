//
//  AttendanceMember.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/03/17.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

struct AttendanceMember {
    let name: String
    let platform: PlatformTeam
    let firstSeminarAttendance: AttendanceStyle
    let firstSeminarAttendanceTime: Date?
    let secondSeminarAttendance: AttendanceStyle
    let secondSeminarAttendanceTime: Date?
}

extension AttendanceMember {
    static let dummy: [AttendanceMember] = [
        AttendanceMember(name: "김남수",
                         platform: .iOS,
                         firstSeminarAttendance: .attend,
                         firstSeminarAttendanceTime: Date(),
                         secondSeminarAttendance: .attend,
                         secondSeminarAttendanceTime: Date()),
        AttendanceMember(name: "김남수1",
                         platform: .iOS,
                         firstSeminarAttendance: .lateness,
                         firstSeminarAttendanceTime: Date().addingTimeInterval(10000),
                         secondSeminarAttendance: .attend,
                         secondSeminarAttendanceTime: Date().addingTimeInterval(16000)),
        AttendanceMember(name: "김남수2",
                         platform: .android,
                         firstSeminarAttendance: .attend,
                         firstSeminarAttendanceTime: Date(),
                         secondSeminarAttendance: .absence,
                         secondSeminarAttendanceTime: Date()),
    ]
}
