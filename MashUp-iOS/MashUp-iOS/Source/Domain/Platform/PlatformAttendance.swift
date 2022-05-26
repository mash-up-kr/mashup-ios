//
//  PlatformAttendance.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/05/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

struct PlatformAttendance: Equatable {
    let platform: PlatformTeam
    let numberOfAttend: Int
    let numberOfLateness: Int
    let numberOfAbsence: Int
}
