//
//  PlatformRepository.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/05/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxSwift

public protocol PlatformRepository {
    func allPlatformTeams() -> Observable<[PlatformTeam]>
    func attendanceStatus() -> Observable<[PlatformAttendance]>
}

final public class PlatformRepositoryImpl: PlatformRepository {
    
    public init() {}
    
    public func allPlatformTeams() -> Observable<[PlatformTeam]> {
        return .just(PlatformTeam.allCases)
    }
    
    public func attendanceStatus() -> Observable<[PlatformAttendance]> {
        return .empty()
    }
    
}
