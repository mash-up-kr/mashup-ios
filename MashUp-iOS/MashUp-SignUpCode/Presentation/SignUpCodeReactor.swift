//
//  SignUpCodeReactor.swift
//  MashUp-SignUpCode
//
//  Created by Booung on 2022/06/03.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import ReactorKit

enum SignUpCodeStep {}

final class SignUpCodeReactor: Reactor {
    
    enum Action {
        case didEditSignUpCodeField(String)
        case didTapDone
    }
    
    enum Mutation {
        case updateSignUpCode(String)
        case move(to: SignUpCodeStep)
    }
    
    struct State {
        var signUpCode: String = .empty
        var canDone: Bool = false
        
        @Pulse var step: SignUpCodeStep?
    }
    
    let initialState: State = State()
    
    init(signUpCodeVerificationService: any SignUpCodeVerificationService) {
        self.signUpCodeVerificationService = signUpCodeVerificationService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didEditSignUpCodeField(let signUpCode):
            return .just(.updateSignUpCode(signUpCode))
            
        case .didTapDone:
            let verifyCode = self.signUpCodeVerificationService.verify(signUpCode: self.currentState.signUpCode)
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateSignUpCode(let signUpCode):
            newState.signUpCode = signUpCode
        }
        return newState
    }
    
    private let signUpCodeVerificationService: any SignUpCodeVerificationService
    
}
