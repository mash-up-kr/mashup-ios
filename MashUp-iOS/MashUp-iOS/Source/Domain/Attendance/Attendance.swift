//
//  Attendance.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/03/19.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

struct Attendance {
    let phase: SeminarPhase
    let status: AttendanceStatus?
    let timeStamp: Date?
}
extension Attendance {
    static func unloaded(_ phase: SeminarPhase) -> Attendance {
        return Attendance(phase: phase,
                          status: nil,
                          timeStamp: nil)
    }
}

extension Array where Element == Attendance {
    static let unloaded = [
        Attendance(phase: .phase1, status: nil, timeStamp: nil),
        Attendance(phase: .phase2, status: nil, timeStamp: nil),
        Attendance(phase: .total, status: nil, timeStamp: nil)
    ]
}
