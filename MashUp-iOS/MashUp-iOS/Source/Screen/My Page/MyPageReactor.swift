//
//  MyPageReactor.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/06/18.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import ReactorKit
import MashUp_PlatformTeam
import MashUp_User

enum MyPageStep: Equatable {
    case setting
    case clubActivityScoreRule
}

class MyPageReactor: Reactor {
    
    enum Action {
        case didSetup
        case didTapSettingButton
        case didTapQuestMarkButton
        case didAppearHeaderView
        case didDisappearHeaderView
        case didTap5TimesMascot
    }
    
    enum Mutation {
        case updateLoading(Bool)
        case updateSummaryBarVisablity(Bool)
        case updateSummaryBar(MyPageSummaryBarModel)
        case updateHeader(MyPageHeaderViewModel)
        case updateSections([MyPageSection])
        case moveTo(MyPageStep)
    }
    
    struct State {
        var isLoading: Bool = false
        var summaryBarHasVisable: Bool = false
        var summaryBarModel: MyPageSummaryBarModel?
        var headerModel: MyPageHeaderViewModel?
        var sections: [MyPageSection] = []
        
        @Pulse var step: MyPageStep?
        
        fileprivate let userName: String
        fileprivate let userPlatform: PlatformTeam
        fileprivate var totalClubActivityScore: String = .empty
        fileprivate var generation: Generation?
    }
    
    let initialState: State
    
    init(
        userSession: UserSession,
        clubActivityService: any ClubActivityService,
        debugSystem: any DebugSystem
    ) {
        self.initialState = State(userName: userSession.name, userPlatform: userSession.platformTeam)
        self.clubActivityService = clubActivityService
        self.debugSystem = debugSystem
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
    
    private func formatSections(with histories: [Generation: [ClubActivityHistory]]) -> [MyPageSection] {
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
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didSetup:
            let startLoading: Observable<Mutation> = .just(.updateLoading(true))
            let loadHistories: Observable<Mutation> = self.clubActivityService.histories(generation: 12)
                .map { histories in self.formatSections(with: [12: histories]) }
                .map { .updateSections($0) }
            let endLoading: Observable<Mutation> = .just(.updateLoading(false))
            
            return .concat(startLoading, loadHistories, endLoading)
            
        case .didTapSettingButton:
            return .just(.moveTo(.setting))
            
        case .didTapQuestMarkButton:
            return .just(.moveTo(.clubActivityScoreRule))
            
        case .didAppearHeaderView:
            return .just(.updateSummaryBarVisablity(false))
            
        case .didDisappearHeaderView:
            return .just(.updateSummaryBarVisablity(true))
            
        case .didTap5TimesMascot:
            self.debugSystem.on()
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateLoading(let isLoading):
            newState.isLoading = isLoading
            
        case .updateSummaryBarVisablity(let isVisable):
            newState.summaryBarHasVisable = isVisable
            
        case .updateSummaryBar(let summaryBarModel):
            newState.summaryBarModel = summaryBarModel
            
        case .updateHeader(let headerModel):
            newState.headerModel = headerModel
            
        case .updateSections(let sections):
            newState.sections = sections
            
        case .moveTo(let step):
            newState.step = step
        }
        return newState
    }
    
    private let clubActivityService: any ClubActivityService
    private let debugSystem: any DebugSystem
    
}
