//
//  AttendanceTimeline.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/03/19.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

struct AttendanceTimeline {
    let partialAttendance1: PartialAttendance?
    let partialAttendance2: PartialAttendance?
    var totalAttendance: PartialAttendance {
        let totalStatus = self.evaluate(self.partialAttendance1?.status, status2: self.partialAttendance2?.status)
        return PartialAttendance(phase: .total, status: totalStatus, timestamp: nil)
    }
    
    private func evaluate(_ status1: AttendanceStatus?, status2: AttendanceStatus?) -> AttendanceStatus? {
        guard let status1 = status1, let status2 = status2 else { return nil }

        if status1 == .attend && status2 == .attend {
            return .attend
        } else if status1 == .lateness && status2 == .attend {
            return .lateness
        } else {
            return .absence
        }
    }
}

extension AttendanceTimeline {
    static let unloaded = AttendanceTimeline(partialAttendance1: .unloaded(.phase1),
                                             partialAttendance2: .unloaded(.phase2))
    
}
