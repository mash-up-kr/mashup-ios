//
//  AttendanceTimelineRepository.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/03/19.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxSwift
import MashUp_Auth

protocol AttendanceTimelineRepository {
    func attendanceTimeline(ofUserID userID: UserSession.ID, seminarID: Seminar.ID) -> Observable<AttendanceTimeline>
}

final class AttendanceTimelineRepositoryImpl: AttendanceTimelineRepository {
    
    func attendanceTimeline(ofUserID userID: UserSession.ID, seminarID: Seminar.ID) -> Observable<AttendanceTimeline> {
        return .empty()
    }
    
}
