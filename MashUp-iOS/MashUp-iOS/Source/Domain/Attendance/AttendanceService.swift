//
//  AttendanceService.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/02.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxSwift
import MashUp_PlatformTeam
import MashUp_Network

protocol AttendanceService {
    func attend(withCode code: Code) -> Observable<Bool>
    func attendanceMembers(platform: PlatformTeam) -> Observable<[AttendanceMember]>
}

protocol AttendanceRepository {
    func attend(withCode: Code) async -> Bool
}

final class AttendanceServiceImpl: AttendanceService {
    
    init(attendanceRepository: any AttendanceRepository) {
        self.attendanceRepository = attendanceRepository
    }
    
    func attend(withCode code: Code) -> Observable<Bool> {
        AsyncStream.single { await self.attendanceRepository.attend(withCode: code) }.asObservable()
    }
    
    func attendanceMembers(platform: PlatformTeam) -> Observable<[AttendanceMember]> {
        return .empty()
    }
    
    private let attendanceRepository: any AttendanceRepository
    
}
