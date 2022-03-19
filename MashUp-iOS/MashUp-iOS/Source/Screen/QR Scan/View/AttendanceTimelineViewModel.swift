//
//  AttendanceTimelineViewModel.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/03/20.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

struct AttendanceTimelineViewModel: Equatable {
    let phase1: PhaseAttendanceViewModel
    let phase2: PhaseAttendanceViewModel
    let total: PhaseAttendanceViewModel
}
extension AttendanceTimelineViewModel {
    static let unloaded = AttendanceTimelineViewModel(
        phase1: .unloaded(.phase1),
        phase2: .unloaded(.phase2),
        total: .unloaded(.total)
    )
}
