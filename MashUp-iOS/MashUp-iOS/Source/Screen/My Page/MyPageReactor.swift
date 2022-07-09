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
        case updateSummaryBarVisablity(Bool)
        case updateSections([MyPageSection])
        case moveTo(step: MyPageStep)
    }
    
    struct State {
        var summaryBarHasVisable: Bool = false
        var summaryBarModel: MyPageSummaryBarModel?
        var headerModel: MyPageHeaderViewModel?
        var sections: [MyPageSection] = []
        
        @Pulse var step: MyPageStep?
        
        fileprivate var totalClubActivityScore: String = .empty
        fileprivate let userName: String
        fileprivate let userPlatform: PlatformTeam
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
    
    private func randomItem() -> ClubActivityHistoryCellModel {
        return ClubActivityHistoryCellModel(
            historyTitle: "전체 세미나 지각",
            description: "2022.03.05 | 2차 전체 세미나",
            scoreChangeStyle: [.addition("+1점"), .deduction("-1점"), .custom("💖 🔫")].randomElement()!,
            appliedTotalScoreText: "4점"
        )
    }
    
    private func sections() -> [MyPageSection] {
        let titleHeader = MyPageSection.TitleHeader(title: "출석 히스토리")
        let generationHeader1 = MyPageSection.HistoryHeader(generationText: "12기")
        let historyItems1: [MyPageSection.Item] = (0..<10).map { _ in .history(randomItem()) }
        let generationHeader2 = MyPageSection.HistoryHeader(generationText: "11기")
        let historyItems2: [MyPageSection.Item] = (0..<10).map { _ in .history(randomItem()) }
        
        let sections: [MyPageSection] = [
            .title(titleHeader),
            .histories(generationHeader1, items: historyItems1),
            .histories(generationHeader2, items: historyItems2),
        ]
        //        let sections: [MyPageSection] = [.title(titleHeader), .empty]
        return sections
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didSetup:
            self.clubActivityService.histories(generation: 12)
            let sections = self.sections()
            return .just(.updateSections(sections))
            
        case .didTapSettingButton:
            return .just(.moveTo(step: .setting))
            
        case .didTapQuestMarkButton:
            return .just(.moveTo(step: .clubActivityScoreRule))
            
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
        case .updateSections(let sections):
            newState.sections = sections
            
        case .updateSummaryBarVisablity(let isVisable):
            newState.summaryBarHasVisable = isVisable
            
        case .moveTo(let step):
            newState.step = step
        }
        return newState
    }
    
    private let clubActivityService: any ClubActivityService
    private let debugSystem: any DebugSystem
    
}
