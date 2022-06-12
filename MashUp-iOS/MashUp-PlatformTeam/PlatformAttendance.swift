//
//  PlatformAttendance.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/05/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

public struct PlatformAttendance: Equatable {
    public let platformAttendanceInformations: [PlatformAttendanceInformation]
    public let isAttending: Bool
    
    public init(platformAttendanceInformations: [PlatformAttendanceInformation],
                isAttending: Bool) {
        self.platformAttendanceInformations = platformAttendanceInformations
        self.isAttending = isAttending
    }
}

public struct PlatformAttendanceInformation: Equatable {
    public let platform: PlatformTeam
    public let numberOfAttend: Int
    public let numberOfLateness: Int
    public let numberOfAbsence: Int
    
    public init(
        platform: PlatformTeam,
        numberOfAttend: Int,
        numberOfLateness: Int,
        numberOfAbsence: Int
    ) {
        self.platform = platform
        self.numberOfAttend = numberOfAttend
        self.numberOfLateness = numberOfLateness
        self.numberOfAbsence = numberOfAbsence
    }
}
