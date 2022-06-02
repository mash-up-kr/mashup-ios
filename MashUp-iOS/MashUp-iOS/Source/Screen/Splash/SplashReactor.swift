//
//  SplashReactor.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/25.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import ReactorKit
import MashUp_Auth
import MashUp_User

final class SplashReactor: Reactor {
    
    enum Action {
        case didSetup
    }
    
    enum Mutation {
        case updateUserSession(UserSession?)
    }
    
    struct State {}
    
    let initialState: State
    
    init(
        userAuthService: any UserAuthService,
        authenticationResponder: any AuthenticationResponder
    ) {
        self.initialState = State()
        self.userAuthService = userAuthService
        self.authenticationResponder = authenticationResponder
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didSetup:
            let splashDuration = RxTimeInterval.seconds(1)
            return self.loadUserSession(until: splashDuration)
                .map { .updateUserSession($0) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        switch mutation {
        case .updateUserSession(let userSession):
            if let userSession = userSession {
                self.authenticationResponder.loadSuccess(userSession: userSession)
            } else {
                self.authenticationResponder.loadFailure()
            }
        }
        return state
    }
    
    private func loadUserSession(until timeout: RxTimeInterval) -> Observable<UserSession?> {
        return self.userAuthService.autoSignIn()
            .timeout(timeout, scheduler: ConcurrentDispatchQueueScheduler(qos: .background))
            .catchAndReturn(nil)
    }
    
    private let userAuthService: any UserAuthService
    private let authenticationResponder: any AuthenticationResponder
    
}
