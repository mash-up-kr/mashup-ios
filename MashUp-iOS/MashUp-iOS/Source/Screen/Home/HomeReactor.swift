//
//  HomeReactor.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/25.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import RxSwift
import ReactorKit

enum HomeStep: Equatable {
    case qr
    case attendanceComplete
}

final class HomeReactor: Reactor {
    
    enum Action {
        case didSelectTabItem(at: Int)
        case didTapQRButton
        case didCompleteAttendance
    }
    
    struct State {
        var currentTab: HomeTab
        var tabItems: [HomeTab]
        
        @Pulse var step: HomeStep?
    }
    
    let initialState: State
    
    init() {
        self.initialState = State(
            currentTab: .seminarSchedule,
            tabItems: HomeTab.allCases
        )
    }
    
    func reduce(state: State, mutation: Action) -> State {
        var newState = state
        switch mutation {
        case .didSelectTabItem(let index):
            guard let selectedTab = state.tabItems[safe: index] else { return state }
            newState.currentTab = selectedTab
            
        case .didTapQRButton:
            newState.step = .qr
            
        case .didCompleteAttendance:
            newState.step = .attendanceComplete
        }
        return newState
    }
}
extension HomeReactor: QRCodeAttendanceResponder {
    
    func didCompleteAttendance() {
        self.action.onNext(.didCompleteAttendance)
    }
    
}
