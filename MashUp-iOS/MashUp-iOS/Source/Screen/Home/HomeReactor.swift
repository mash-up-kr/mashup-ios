//
//  HomeReactor.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/25.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import RxSwift
import ReactorKit

final class HomeReactor: Reactor {
    
    enum Action {
        case didSelectTabItem(at: Int)
    }
    
    struct State {
        var currentTab: HomeTab
        var tabItems: [HomeTab]
    }
    
    let initialState: State
    
    init() {
        self.initialState = State(
            currentTab: .qr,
            tabItems: HomeTab.allCases
        )
    }
    
    func reduce(state: State, mutation: Action) -> State {
        var newState = state
        switch mutation {
        case .didSelectTabItem(let index):
            guard let selectedTab = state.tabItems[safe: index] else { return state }
            newState.currentTab = selectedTab
        }
        return newState
    }
}
