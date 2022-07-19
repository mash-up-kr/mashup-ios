//
//  AttendanceStatusEntity.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/07/20.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

enum AttendanceStatusEntity: String, Decodable {
    case attendance = "ATTENDANCE"
    case late = "LATE"
    case absent = "ABSENT"
}
