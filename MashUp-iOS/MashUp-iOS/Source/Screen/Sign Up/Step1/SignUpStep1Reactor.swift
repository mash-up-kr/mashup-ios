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

enum SignUpStep1Step {
    case signUpStep2(id: String, password: String)
}

final class SignUpStep1Reactor: Reactor {
    
    typealias Step = SignUpStep1Step
    
    enum Action {
        case didEditIDField(String)
        case didEditPasswordField(String)
        case didFocusPasswordCheckField
        case didEditPasswordCheckField(String)
        case didOutOfFocusPasswordCheckField
        case didTapBack
        case didTapDoneButton
    }
    
    enum Mutation {
        case updateID(String)
        case updatePassword(String)
        case updatePasswordCheck(String)
        case updateCanScroll(Bool)
        case updateScrollToTop
        case updateFocusPasswordCheckField
        case close
        case move(to: Step)
    }
    
    struct State {
        var id: String = .empty
        var password: String = .empty
        var passwordCheck: String = .empty
        
        var canDone: Bool = false
        var canScroll: Bool = false
        var hasVaildatedID: Bool?
        var hasVaildatedPassword: Bool?
        var hasVaildatedPasswordCheck: Bool?
        
        @Pulse var shouldClose: Void?
        @Pulse var shouldScrollToTop: Void?
        @Pulse var shouldFocusPasswordCheckField: Void?
        @Pulse var step: Step?
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
            
        case .didFocusPasswordCheckField:
            return .of(.updateCanScroll(true), .updateFocusPasswordCheckField)
            
        case .didEditPasswordCheckField(let passwordCheck):
            return .just(.updatePasswordCheck(passwordCheck))
            
        case .didOutOfFocusPasswordCheckField:
            return .of(.updateCanScroll(false), .updateScrollToTop)
            
        case .didTapBack:
            return .just(.close)
            
        case .didTapDoneButton:
            #warning("실제 id 중복 체크 와 같은 검증 작업 필요")
            guard self.currentState.canDone else { return .empty() }
            
            let id = self.currentState.id
            let password = self.currentState.password
            return .just(.move(to: .signUpStep2(id: id, password: password)))
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
       
        case .updateCanScroll(let canScroll):
            newState.canScroll = canScroll
            
        case .updateScrollToTop:
            newState.shouldScrollToTop = Void()
            
        case .updateFocusPasswordCheckField:
            newState.shouldFocusPasswordCheckField = Void()
            
        case .close:
            newState.shouldClose = Void()
            
        case .move(let step):
            newState.step = step
        }
        newState.canDone = self.allSatisfied(newState)
        return newState
    }
    
    private func allSatisfied(_ state: State) -> Bool {
        state.hasVaildatedID == true && state.hasVaildatedPassword == true && state.hasVaildatedPasswordCheck == true
    }
    
    private let verificationService: any VerificationService
    
}
