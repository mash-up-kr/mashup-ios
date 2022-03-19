//
//  AttendanceTimeline.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/03/19.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

struct AttendanceTimeline {
    let phase1: Attendance?
    let phase2: Attendance?
    var total: Attendance {
        let totalStatus = self.evaulate(self.phase1?.status, status2: self.phase2?.status)
        return Attendance(phase: .total, status: totalStatus, timeStamp: nil)
    }
    
    private func evaulate(_ status1: AttendanceStatus?, status2: AttendanceStatus?) -> AttendanceStatus? {
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
    static let unloaded = AttendanceTimeline(phase1: .unloaded(.phase1),
                                             phase2: .unloaded(.phase2))
    
}
