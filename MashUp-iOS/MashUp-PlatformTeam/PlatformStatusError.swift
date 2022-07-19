//
//  PlatformStatusError.swift
//  MashUp-PlatformTeam
//
//  Created by 김남수 on 2022/07/19.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_Core

public enum PlatformAttendanceError: String, Error {
    case noContent = "EVENT_NOT_FOUND"
    case undefined
}

extension MashUpError {
    var asPlatformAttendanceError: PlatformAttendanceError {
        return PlatformAttendanceError(rawValue: self.code ?? "") ?? .undefined
    }
}
