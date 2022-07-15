//
//  PersonalInfomationPolicyReactor.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/07/15.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import ReactorKit

final class PersonalInfomationPolicyReactor: Reactor {
    
    enum Action {
        case didSetup
        case didTapClose
    }
    
    struct State {
        var personalInfomationPolicyURL: URL?
        @Pulse var shouldClose: Void?
    }
    
    var initialState: State = State()
    
    func reduce(state: State, mutation: Action) -> State {
        var newState = state
        switch mutation {
        case .didSetup:
            newState.personalInfomationPolicyURL = URL(string: "https://static.mash-up.kr/Mash-Up-app-personal-infomation-policy/index.html")!
        case .didTapClose:
            newState.shouldClose = Void()
        }
        return newState
    }
    
}
