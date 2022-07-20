//
//  PlatformService.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/05/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxSwift

public protocol PlatformService {
    func allPlatformTeams() -> Observable<[PlatformTeam]>
    func attendanceStatus(scheduleID: Int) -> Observable<PlatformAttendance>
}

final public class PlatformServiceImpl: PlatformService {
    
    public init(repository: PlatformRepository) {
        self.repository = repository
    }
    
    public func allPlatformTeams() -> Observable<[PlatformTeam]> {
        return repository.allPlatformTeams()
    }
    
    public func attendanceStatus(scheduleID: Int) -> Observable<PlatformAttendance> {
        return repository.attendanceStatus(scheduleID: scheduleID)
    }
    
    private let repository: PlatformRepository
    
}
