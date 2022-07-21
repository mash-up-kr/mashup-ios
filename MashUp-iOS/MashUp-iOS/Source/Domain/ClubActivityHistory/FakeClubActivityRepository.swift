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

final class FakeClubActivityRepository: ClubActivityRepository {
    
    func totalClubActivityScore() -> Observable<ClubActivityScore> {
        return .just(10)
    }
    
    func histories(generation: Generation) -> Observable<[ClubActivityHistory]> {
        let numberOfHistory = 50
        let histories = (0..<numberOfHistory).map { _ in self.randomClubActivityHistory() }
        return .just(histories)
    }
    
    private func randomClubActivityHistory() -> ClubActivityHistory {
        let activityTitles = ["해커톤 준비 위원회", "전체 세미나 지각", "프로젝트 배포 성공", "기술블로그", "Mash-Up 콘텐츠 작성"]
        let changedScoreRange = -3...1
        let appliedTotalScoreRange = -3...20
        
        let monthRange = 1...12
        let dayRange = 1...28
        let eventTitles = ["해커톤 준비 위원회", "전체 세미나 지각", ""]
        
        return ClubActivityHistory(
            id: UUID().uuidString,
            activityTitle: activityTitles.randomElement()!,
            changedScore: changedScoreRange.randomElement()!,
            appliedTotalScore: appliedTotalScoreRange.randomElement()!,
            date: Date(year: 2022, month: monthRange.randomElement()!, day: dayRange.randomElement()!, hour: 0, minute: 0, second: 0),
            eventTitle: eventTitles.randomElement()!
        )
    }
    
}
