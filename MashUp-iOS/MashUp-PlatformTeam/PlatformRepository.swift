//
//  PlatformRepository.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/05/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxSwift
import MashUp_Network

public protocol PlatformRepository {
    func allPlatformTeams() -> Observable<[PlatformTeam]>
    func attendanceStatus(scheduleID: Int) -> Observable<PlatformAttendance>
}

final public class PlatformRepositoryImpl: PlatformRepository {
    private let network: Network
    
    public init(network: any Network) {
        self.network = network
    }
    
    public func allPlatformTeams() -> Observable<[PlatformTeam]> {
        return .just(PlatformTeam.allCases)
    }
    
    public func attendanceStatus(scheduleID: Int) -> Observable<PlatformAttendance> {
        let api = PlatformAttendanceAPI(scheduleID: scheduleID)
        return network.request(api)
            .compactMap { try $0.get() }
            .map { $0.asPlatformAttendance }
    }
}

extension PlatformRepositoryImpl {
    fileprivate static var mockPlatformAttendance: PlatformAttendance {
        let informations: [PlatformAttendanceInformation]
        = [.init(platform: .iOS, numberOfAttend: 0, numberOfLateness: 10, numberOfAbsence: 2),
           .init(platform: .android, numberOfAttend: 5, numberOfLateness: 10, numberOfAbsence: 2),
           .init(platform: .design, numberOfAttend: 10, numberOfLateness: 10, numberOfAbsence: 20)]
        return .init(platformAttendanceInformations: informations, isAttending: true)
    }
}
