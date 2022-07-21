//
//  AttendanceCompleteReactor.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/07/18.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import ReactorKit

final class AttendanceCompleteReactor: Reactor {
    
    enum Action {
        case didSetup
    }
    
    enum Mutation {
        case close
    }
    
    struct State {
        @Pulse var shouldClose: Void?
    }
    
    let initialState = State()
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didSetup:
            let close =  Observable<Mutation>.just(.close)
            return close.delay(.seconds(1), scheduler: MainScheduler.instance)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .close:
            newState.shouldClose = Void()
        }
        return newState
    }
    
}
