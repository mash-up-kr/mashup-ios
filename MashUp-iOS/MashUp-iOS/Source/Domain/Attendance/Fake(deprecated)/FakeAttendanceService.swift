//
//  FakeAttendanceService.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/02.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxSwift

final class FakeAttendanceService: AttendanceService {
    
    var stubedCorrectCode: Code?
    
    func attend(withCode code: Code) -> Observable<Bool> {
        let isCorrectCode = code == self.stubedCorrectCode
        
        return .just(isCorrectCode)
    }
    
    func attendanceMembers(platform: PlatformTeam?) -> Observable<[AttendanceMember]> {
        return .just(AttendanceMember.dummy)
    }
}
