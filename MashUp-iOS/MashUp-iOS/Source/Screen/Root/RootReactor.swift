//
//  RootReactor.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/25.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import ReactorKit
import MashUp_Auth
import MashUp_User

final class RootReactor: Reactor {
    
    enum Action {
        case didSetup
        case didLoad(UserSession?)
    }
    
    struct State {
        @Pulse var step: RootStep?
    }
    
    let initialState: State
    
    init() {
        self.initialState = State(step: nil)
    }
    
    func reduce(state: State, mutation: Action) -> State {
        var newState = state
        switch mutation {
        case .didSetup:
            newState.step = .splash
            
        case .didLoad(let userSession):
            if let userSession = userSession {
                newState.step = .home(userSession)
            } else {
                newState.step = .signIn
            }
        }
        return newState
    }
    
}
extension RootReactor: AuthenticationResponder {
    
    func loadSuccess(userSession: UserSession) {
        self.action.onNext(.didLoad(userSession))
    }
    
    func loadFailure() {
        self.action.onNext(.didLoad(nil))
    }

}
