//
//  Attendance.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/03/19.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

struct PartialAttendance: Equatable {
    let phase: SeminarPhase
    let status: AttendanceStatus?
    let timestamp: Date?
}
extension PartialAttendance {
    static func unloaded(_ phase: SeminarPhase) -> PartialAttendance {
        return PartialAttendance(phase: phase,
                                 status: nil,
                                 timestamp: nil)
    }
}

extension Array where Element == PartialAttendance {
    static let unloaded = [
        PartialAttendance(phase: .phase1, status: nil, timestamp: nil),
        PartialAttendance(phase: .phase2, status: nil, timestamp: nil),
        PartialAttendance(phase: .total, status: nil, timestamp: nil)
    ]
}
