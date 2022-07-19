//
//  QRAttendanceError.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/07/20.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_Core

enum AttendanceError: String, Error {
    case wrongAttendanceCode = "ATTENDANCE_CODE_NOT_FOUND"
    case undefined
}

extension MashUpError {
    func asAttendanceError() -> AttendanceError {
        return AttendanceError(rawValue: self.code) ?? .undefined
    }
}
