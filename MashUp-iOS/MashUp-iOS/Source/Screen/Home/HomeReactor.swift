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
        case didSelectTabItem(Int)
    }
    
    struct State {
        var currentTab: HomeTab
        var tabItems: [HomeTab]
    }
    
    let initialState: State
    
    init() {
        self.initialState = State(
            currentTab: .seminarSchedule,
            tabItems: HomeTab.allCases
        )
    }
}