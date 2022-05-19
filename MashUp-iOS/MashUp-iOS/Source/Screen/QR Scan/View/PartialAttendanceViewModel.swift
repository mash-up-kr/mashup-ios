//
//  PartialAttendanceViewModel.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/03/20.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

struct PartialAttendanceViewModel: Equatable {
    let phase: SeminarPhase
    let timestamp: String?
    let style: AttendanceStyle
}
extension PartialAttendanceViewModel {
    static func unloaded(_ phase: SeminarPhase) -> PartialAttendanceViewModel {
       return PartialAttendanceViewModel(phase: phase, timestamp: nil, style: .upcoming)
    }
}
