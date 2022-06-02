//
//  FakeAttendanceTimelineRepository.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/03/19.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxSwift
import MashUp_Auth

class FakeAttendanceTimelineRepository: AttendanceTimelineRepository {
    
    var stubbedTimeline: AttendanceTimeline?
    
    func attendanceTimeline(ofUserID userID: UserSession.ID, seminarID: Seminar.ID) -> Observable<AttendanceTimeline> {
        guard let stubbedPhase = self.stubbedTimeline else { return .empty() }
        return .just(stubbedPhase)
    }
    
}
