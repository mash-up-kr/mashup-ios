//
//  SignUpCodeReactor.swift
//  MashUp-SignUpCode
//
//  Created by Booung on 2022/06/03.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import ReactorKit

public enum SignUpCodeStep {}

final public class SignUpCodeReactor: Reactor {
    
    public enum Action {
        case didEditSignUpCodeField(String)
        case didTapDone
    }
    
    public enum Mutation {
        case updateSignUpCode(String)
        case move(to: SignUpCodeStep)
    }
    
    public struct State {
        var signUpCode: String = .empty
        var canDone: Bool = false
        
        @Pulse var step: SignUpCodeStep?
    }
    
    public let initialState: State = State()
    
    public init(signUpCodeVerificationService: any SignUpCodeVerificationService) {
        self.signUpCodeVerificationService = signUpCodeVerificationService
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didEditSignUpCodeField(let signUpCode):
            let signCode5Digits = String(signUpCode.prefix(5))
            return .just(.updateSignUpCode(signCode5Digits))
            
        case .didTapDone:
            let verifyCode = self.signUpCodeVerificationService.verify(signUpCode: self.currentState.signUpCode)
            return .empty()
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateSignUpCode(let signUpCode):
            newState.signUpCode = signUpCode
            newState.canDone = self.satisfy(signUpCode: signUpCode)
        }
        return newState
    }
    
    private func satisfy(signUpCode: String) -> Bool {
        return signUpCode.count == 5
    }
    
    private let signUpCodeVerificationService: any SignUpCodeVerificationService
    
}
