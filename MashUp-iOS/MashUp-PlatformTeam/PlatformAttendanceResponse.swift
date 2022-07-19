//
//  PlatformStatusResponse.swift
//  MashUp-PlatformTeam
//
//  Created by 김남수 on 2022/07/19.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

public struct PlatformAttendanceResponse: Decodable {
    let isEnd: Bool
    let platformInfos: [PlatformInfo]
    
    public init(isEnd: Bool, platformInfos: [PlatformAttendanceResponse.PlatformInfo]) {
        self.isEnd = isEnd
        self.platformInfos = platformInfos
    }
}

extension PlatformAttendanceResponse {
    public struct PlatformInfo: Decodable {
        let platform: String
        let attendanceCount: Int?
        let lateCount: Int?
        let totalCount: Int?
        
        public init(attendanceCount: Int?, lateCount: Int?, platform: String, totalCount: Int?) {
            self.attendanceCount = attendanceCount
            self.lateCount = lateCount
            self.platform = platform
            self.totalCount = totalCount
        }
    }
    
    public var asPlatformAttendance: PlatformAttendance {
        let platformInfos = self.platformInfos.map { $0.asPlatformAttendance }
        return PlatformAttendance(
            platformAttendanceInformations: platformInfos,
            isAttending: self.isEnd
        )
    }
}

extension PlatformAttendanceResponse.PlatformInfo {
    public var asPlatformAttendance: PlatformAttendanceInformation {
        var absence = (self.totalCount ?? 0) - (self.attendanceCount ?? 0) - (self.lateCount ?? 0)
        absence = absence <= 0 ? 0 : absence
        return PlatformAttendanceInformation(
            platform: PlatformTeam(rawValue: self.platform.uppercased()),
            numberOfAttend: self.attendanceCount ?? 0,
            numberOfLateness: self.lateCount ?? 0,
            numberOfAbsence: absence
        )
    }
}
