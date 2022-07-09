//
//  MyPageReactor.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/06/18.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import ReactorKit

enum MyPageStep: Equatable {
    case setting
    case attendanceScoreRule
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
        var sections: [MyPageSection] = []
        
        @Pulse var step: MyPageStep?
    }
    
    let initialState: State = State()
    
    init(debugSystem: any DebugSystem) {
        self.debugSystem = debugSystem
    }
    
    private func randomItem() -> AttendanceScoreHistoryCellModel {
        return AttendanceScoreHistoryCellModel(
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
        
//        let sections: [MyPageSection] = [
//            .title(titleHeader),
//            .historys(generationHeader1, items: historyItems1),
//            .historys(generationHeader2, items: historyItems2),
//        ]
        let sections: [MyPageSection] = [.empty]
        return sections
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didSetup:
            let sections = self.sections()
            return .just(.updateSections(sections))
            
        case .didTapSettingButton:
            return .just(.moveTo(step: .setting))
            
        case .didTapQuestMarkButton:
            return .just(.moveTo(step: .attendanceScoreRule))
            
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
    
    private let debugSystem: any DebugSystem
    
}
