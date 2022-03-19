//
//  PhaseAttendanceViewModel.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/03/20.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

struct PhaseAttendanceViewModel: Equatable {
    let phase: SeminarPhase
    let timeStamp: String?
    let style: AttendanceStyle
}
extension PhaseAttendanceViewModel {
    static func unloaded(_ phase: SeminarPhase) -> PhaseAttendanceViewModel {
       return PhaseAttendanceViewModel(phase: phase, timeStamp: nil, style: .upcoming)
    }
}
