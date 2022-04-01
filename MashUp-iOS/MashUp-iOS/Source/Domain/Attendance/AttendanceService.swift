//
//  AttendanceService.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/02.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxSwift

protocol AttendanceService {
    func attend(withCode code: Code) -> Observable<Bool>
    
    func attendanceMembers(platform: PlatformTeam?) -> Observable<[AttendanceMember]>
}

final class AttendanceServiceImpl: AttendanceService {
    
    func attend(withCode code: Code) -> Observable<Bool> {
        return .empty()
    }
    
    func attendanceMembers(platform: PlatformTeam?) -> Observable<[AttendanceMember]> {
        return .empty()
    }
}
