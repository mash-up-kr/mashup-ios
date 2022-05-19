//
//  AttendanceTimelineViewModel.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/03/20.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

struct AttendanceTimelineViewModel: Equatable {
    let partialAttendance1: PartialAttendanceViewModel
    let partialAttendance2: PartialAttendanceViewModel
    let totalAttendance: PartialAttendanceViewModel
}
extension AttendanceTimelineViewModel {
    static let unloaded = AttendanceTimelineViewModel(
        partialAttendance1: .unloaded(.phase1),
        partialAttendance2: .unloaded(.phase2),
        totalAttendance: .unloaded(.total)
    )
}
