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
        case updateTotalClubActivityScore(ClubActivityScore)
        case moveTo(MyPageStep)
    }
    
    struct State {
        var isLoading: Bool = false
        var summaryBarHasVisable: Bool = false
        var summaryBarModel: MyPageSummaryBarModel?
        var headerModel: MyPageHeaderViewModel?
        var sections: [MyPageSection] = []
        
        @Pulse var step: MyPageStep?
        
        fileprivate let user: UserSession
        fileprivate var totalClubActivityScore: ClubActivityScore?
        fileprivate var generation: Generation?
    }
    
    let initialState: State
    
    init(
        userSession: UserSession,
        clubActivityService: any ClubActivityService,
        formatter: any MyPageFormatter,
        debugSystem: any DebugSystem
    ) {
        self.initialState = State(user: userSession)
        self.clubActivityService = clubActivityService
        self.formatter = formatter
        self.debugSystem = debugSystem
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didSetup:
            let startLoading: Observable<Mutation> = .just(.updateLoading(true))
            let endLoading: Observable<Mutation> = .just(.updateLoading(false))
            let loadTotalScore = self.clubActivityService.totalClubActivityScore().share()
            
            let updateTotalScore: Observable<Mutation> = loadTotalScore
                .map { .updateTotalClubActivityScore($0)}
            let updateSummaryBar: Observable<Mutation> = loadTotalScore
                .map { self.formatter.formatSummaryBar(user: self.currentState.user, totalScore: $0) }
                .map { .updateSummaryBar($0) }
            let updateHeader: Observable<Mutation> = loadTotalScore
                .map { self.formatter.formatHeader(user: self.currentState.user, totalScore: $0) }
                .map { .updateHeader($0) }
            let updateHistorySections: Observable<Mutation> = self.clubActivityService.histories(generation: 12)
                .map { histories in self.formatter.formatSections(with: [12: histories]) }
                .map { .updateSections($0) }
            
            return .concat(
                startLoading,
                updateTotalScore, updateSummaryBar, updateHeader, updateHistorySections,
                endLoading
            )
            
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
            
        case .updateTotalClubActivityScore(let totalClubActivityScore):
            newState.totalClubActivityScore = totalClubActivityScore
            
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
    private let formatter: any MyPageFormatter
    private let debugSystem: any DebugSystem
    
}
