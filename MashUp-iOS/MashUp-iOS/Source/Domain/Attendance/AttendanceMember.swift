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
    let firstSeminarAttendanceTime: Date?
    let secondSeminarAttendanceTime: Date?
}

extension AttendanceMember {
    static let dummy: [AttendanceMember] = [
        AttendanceMember(name: "김남수",
                         platform: .iOS,
                         firstSeminarAttendanceTime: Date(),
                         secondSeminarAttendanceTime: Date()),
        AttendanceMember(name: "김남수1",
                         platform: .iOS,
                         firstSeminarAttendanceTime: Date().addingTimeInterval(10000),
                         secondSeminarAttendanceTime: Date().addingTimeInterval(16000)),
        AttendanceMember(name: "김남수2",
                         platform: .android,
                         firstSeminarAttendanceTime: Date(),
                         secondSeminarAttendanceTime: Date()),
    ]
}
