//
//  MyPageFormatter.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/07/10.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_User

protocol MyPageFormatter {
    func formatSummaryBar(user: UserSession, totalScore: ClubActivityScore) -> MyPageSummaryBarModel
    func formatHeader(user: UserSession, totalScore: ClubActivityScore) -> MyPageHeaderViewModel
    func formatSections(with histories: [Generation: [ClubActivityHistory]]) -> [MyPageSection]
}

class MyPageFormatterImp: MyPageFormatter {
    
    func formatSummaryBar(user: UserSession, totalScore: ClubActivityScore) -> MyPageSummaryBarModel {
        return MyPageSummaryBarModel(
            userName: user.name,
            totalScoreText: "\(totalScore)점"
        )
    }
    
    func formatHeader(user: UserSession, totalScore: ClubActivityScore) -> MyPageHeaderViewModel {
        return MyPageHeaderViewModel(
            userName: user.name,
            platformTeamText: user.platformTeam.title,
            totalScoreText: "\(totalScore)점"
        )
    }
    
    func formatSections(with histories: [Generation: [ClubActivityHistory]]) -> [MyPageSection] {
        let titleHeader = MyPageSection.TitleHeader(title: "활동 히스토리")
        let historySections: [MyPageSection] = histories.map { generation, histories in
            let header = MyPageSection.HistoryHeader(generationText: generation.description)
            let items: [MyPageSection.Item] = histories
                .map { self.formatCell(history: $0) }
                .map { .history($0) }
            return MyPageSection.histories(header, items: items)
        }
        
        let sections: [MyPageSection] = historySections.isNotEmpty
        ? [.title(titleHeader)] + historySections
        : [.empty]
        
        return sections
    }
    
    private func formatCell(history: ClubActivityHistory) -> ClubActivityHistoryCellModel {
        let scoreStyle: ScoreChangeStyle = history.changedScore > 0
        ? .addition("+\(history.changedScore)점")
        : .deduction("\(history.changedScore)점")
        
        return ClubActivityHistoryCellModel(
            historyTitle: history.activityTitle,
            description: "\(history.date.description) | \(history.eventTitle)",
            scoreChangeStyle: scoreStyle,
            appliedTotalScoreText: "\(history.appliedTotalScore)점"
        )
    }
    
}
