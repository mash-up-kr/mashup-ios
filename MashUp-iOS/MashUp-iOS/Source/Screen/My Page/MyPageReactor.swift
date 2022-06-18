//
//  MyPageReactor.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/06/18.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import ReactorKit

enum MyPageStep {
    case setting
    case attendanceSystemGuide
}

class MyPageReactor: Reactor {
    
    enum Action {
        case didTapSettingButton
        case didTapQuestMarkButton
        case didAppearHeaderView
        case didDisappearHeaderView
    }
    
    enum Mutation {
        case updateSummaryBarVisablity(Bool)
        case moveTo(step: MyPageStep)
    }
    
    struct State {
        var summaryBarHasVisable: Bool = false
        
        @Pulse var step: MyPageStep?
    }
    
    let initialState: State = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didTapSettingButton:
            return .just(.moveTo(step: .setting))
            
        case .didTapQuestMarkButton:
            return .just(.moveTo(step: .attendanceSystemGuide))
            
        case .didAppearHeaderView:
            return .just(.updateSummaryBarVisablity(false))
            
        case .didDisappearHeaderView:
            return .just(.updateSummaryBarVisablity(true))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateSummaryBarVisablity(let isVisable):
            newState.summaryBarHasVisable = isVisable
            
        case .moveTo(let step):
            newState.step = step
        }
        return newState
    }
    
}
