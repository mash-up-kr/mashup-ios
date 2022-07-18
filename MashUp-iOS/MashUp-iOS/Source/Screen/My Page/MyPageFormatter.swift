//
//  MyPageFormatter.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/07/10.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_User

protocol MyPageFormatter: AnyObject {
    func formatSummaryBar(userSession: UserSession, totalScore: Int) -> MyPageSummaryBarModel
    func formatHeader(userSession: UserSession, totalScore: Int) -> MyPageHeaderViewModel
    func formatSections(with histories: [Generation: [ClubActivityHistory]]) -> [MyPageSection]
}

final class MyPageFormatterImp: MyPageFormatter {
    
    func formatSummaryBar(userSession: UserSession, totalScore: Int) -> MyPageSummaryBarModel {
        return MyPageSummaryBarModel(
            userName: userSession.name,
            totalScoreText: "\(totalScore)점"
        )
    }
    
    func formatHeader(userSession: UserSession, totalScore: Int) -> MyPageHeaderViewModel {
        return MyPageHeaderViewModel(
            userName: userSession.name,
            platformTeamText: userSession.platformTeam.title,
            platformStyle: .iOS,
            totalScoreText: "\(totalScore)점"
        )
    }
    
    func formatSections(with histories: [Generation: [ClubActivityHistory]]) -> [MyPageSection] {
        let titleHeader = MyPageSection.TitleHeader(title: "활동 히스토리")
        let historySections: [MyPageSection] = histories
            .filter { _, histories in histories.isNotEmpty }
            .map { generation, histories in
                let header = MyPageSection.HistoryHeader(generationText: generation.description)
                let items: [MyPageSection.Item] = histories
                    .map { self.formatCell(history: $0) }
                    .map { .history($0) }
                return MyPageSection.histories(header, items: items)
            }
        
        let sections: [MyPageSection] = historySections.isNotEmpty
        ? [.title(titleHeader)] + historySections
        : [.title(titleHeader), .empty]
        
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
