//
//  SignInReactor.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/24.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import RxSwift
import ReactorKit

final class SignInReactor: Reactor {
    
    enum Action {
        case didEditIDField(String)
        case didEditPasswordField(String)
        case didTapSignInButton
        case didTapSignUpButton
    }
    
    enum Mutation {
        case updateID(String)
        case updatePassword(String)
        case updateLoading(Bool)
        case occurError(Error)
        case moveToScreen(SignInStep)
    }
    
    struct State {
        var id: String = .empty
        var password: String = .empty
        var isLoading: Bool = false
        var canTrySignIn: Bool = false
        
        @Pulse var step: SignInStep?
        @Pulse var alertMessage: String?
        @Pulse fileprivate var occuredError: Error?
    }
    
    let initialState: State = State()
    
    init(userSessionRepository: UserSessionRepository) {
        self.userSessionRepository = userSessionRepository
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didEditIDField(let id):
            return .just(.updateID(id))
            
        case .didEditPasswordField(let password):
            return .just(.updatePassword(password))
            
        case .didTapSignInButton:
            let startLoading = Observable.just(Mutation.updateLoading(true))
            let enterHome = self.signIn().map { userSession in Mutation.moveToScreen(.home(userSession)) }
            let endLoading = Observable.just(Mutation.updateLoading(false))
            return .concat(
                startLoading,
                enterHome,
                endLoading
            ).catch { .just(.occurError($0)) }
            
        case .didTapSignUpButton:
            return .just(.moveToScreen(.signUp))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateID(let id):
            newState.id = id
            newState.canTrySignIn = self.verify(id: state.id, password: state.password)
            
        case .updatePassword(let password):
            newState.password = password
            newState.canTrySignIn = self.verify(id: state.id, password: state.password)
            
        case .updateLoading(let isLoading):
            newState.isLoading = isLoading
            
        case .moveToScreen(let step):
            newState.step = step
            
        case .occurError(let error):
            newState.occuredError = error
        }
        return newState
    }
    
    private func signIn() -> Observable<UserSession> {
        let id = self.currentState.id
        let password = self.currentState.password
        return self.userSessionRepository.signIn(id: id, password: password)
    }
    
    private func verify(id: String, password: String) -> Bool {
        #warning("ID, PW 입력상태에 따른 로그인버튼 활성화 로직 - Booung")
        return true
    }
    
    private let userSessionRepository: UserSessionRepository
    
}
