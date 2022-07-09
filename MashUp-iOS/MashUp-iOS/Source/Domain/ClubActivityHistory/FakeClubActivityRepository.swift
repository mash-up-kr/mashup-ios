//
//  FakeClubActivityRepository.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/07/10.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import RxSwift
import MashUp_User
import Foundation
import MashUp_Network

class FakeClubActivityRepository: ClubActivityRepository {
    
    func totalClubActivityScore(ofUser user: UserSession) -> Observable<ClubActivityScore> {
        return .just(10)
    }
    
    func historys(generation: Generation, ofUser user: UserSession) -> Observable<[ClubActivityHistory]> {
        let activityTitles = ["해커톤 준비 위원회", "전체 세미나 지각", ""]
        let changedScoreRange = -3...1
        let appliedTotalScoreRange = -3...20
        
        let monthRange = 1...12
        let dayRange = 1...28
        let eventTitles = ["해커톤 준비 위원회", "전체 세미나 지각", ""]
        let numberOfHistory = 10
        
        let histories = (0..<numberOfHistory).map { _ in
            ClubActivityHistory(
                id: UUID().uuidString,
                activityTitle: activityTitles.randomElement()!,
                changedScore: changedScoreRange.randomElement()!,
                appliedTotalScore: appliedTotalScoreRange.randomElement()!,
                date: Date(year: 2022, month: monthRange.randomElement()!, day: dayRange.randomElement()!, hour: 0, minute: 0, second: 0),
                eventTitle: eventTitles.randomElement()!
            )
        }
        return .just(histories)
    }
    
}
