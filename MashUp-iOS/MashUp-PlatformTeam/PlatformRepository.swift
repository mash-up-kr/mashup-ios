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
        // TODO: - 네트워크구현후 mock제거
        return .just(PlatformRepositoryImpl.mockObservable)
    }
    
}

extension PlatformRepositoryImpl {
    fileprivate static var mockObservable: [PlatformAttendance] {
        [.init(platform: .iOS, numberOfAttend: 0, numberOfLateness: 10, numberOfAbsence: 2),
         .init(platform: .android, numberOfAttend: 5, numberOfLateness: 10, numberOfAbsence: 2),
         .init(platform: .design, numberOfAttend: 10, numberOfLateness: 10, numberOfAbsence: 20)]
    }
}
