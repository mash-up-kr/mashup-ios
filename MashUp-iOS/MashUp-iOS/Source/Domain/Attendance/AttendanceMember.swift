//
//  AttendanceMember.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/03/17.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

struct AttendanceMember: Equatable {
    let name: String
    let firstSeminarAttendance: AttendanceStatus
    let firstSeminarAttendanceTimeStamp: String?
    let secondSeminarAttendance: AttendanceStatus
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
}
