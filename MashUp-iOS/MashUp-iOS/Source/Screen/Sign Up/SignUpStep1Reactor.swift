//
//  SignUpReactor.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/05/29.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import ReactorKit
import MashUp_Core
import MashUp_PlatformTeam

final class SignUpStep1Reactor: Reactor {
    
    enum Action {
        case didEditIDField(String)
        case didEditPasswordField(String)
        case didEditPasswordCheckField(String)
        case didShowKeyboard
        case didHideKeyboard
        case didTapDoneButton
    }
    
    enum Mutation {
        case updateID(String)
        case updatePassword(String)
        case updatePasswordCheck(String)
    }
    
    struct State {
        var id: String = .empty
        var password: String = .empty
        var passwordCheck: String = .empty
        
        var canDone: Bool = false
        var hasVaildatedID: Bool?
        var hasVaildatedPassword: Bool?
        var hasVaildatedPasswordCheck: Bool?
    }
    
    let initialState: State = State()
    
    init(verificationService: any VerificationService) {
        self.verificationService = verificationService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didEditIDField(let id):
            return .just(.updateID(id))
            
        case .didEditPasswordField(let password):
            return .just(.updatePassword(password))
            
        case .didEditPasswordCheckField(let name):
            return .just(.updatePasswordCheck(name))
            
        case .didTapDoneButton:
            return .empty()
            
        case .didShowKeyboard:
            return .empty()
            
        case .didHideKeyboard:
            return .empty()
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateID(let id):
            newState.id = id
            newState.hasVaildatedID = self.verificationService.verify(id: id)
            
        case .updatePassword(let password):
            newState.password = password
            newState.hasVaildatedPassword = self.verificationService.verify(password: password)
            
        case .updatePasswordCheck(let passwordCheck):
            newState.passwordCheck = passwordCheck
            newState.hasVaildatedPasswordCheck = self.verificationService.verify(password: passwordCheck) && self.currentState.password == passwordCheck
        }
        newState.canDone = self.allSatisfied(newState)
        return newState
    }
    
    private func allSatisfied(_ state: State) -> Bool {
        state.hasVaildatedID == true && state.hasVaildatedPassword == true && state.hasVaildatedPasswordCheck == true
    }
    
    private let verificationService: any VerificationService
    
}
