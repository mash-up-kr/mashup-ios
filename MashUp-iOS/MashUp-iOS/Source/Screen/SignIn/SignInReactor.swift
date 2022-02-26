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
        case move(to: SignInStep)
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
            let startLoading: Observable<Mutation> = .just(Mutation.updateLoading(true))
            let enterHome: Observable<Mutation> = self.signIn().map { userSession in .move(to: .home(userSession)) }
            let endLoading: Observable<Mutation> = .just(Mutation.updateLoading(false))
            let handleError: (Error) -> Observable<Mutation> = { error in return .just(.occurError(error)) }
            return .concat(
                startLoading,
                enterHome,
                endLoading
            ).catch { error in .concat(handleError(error), endLoading) }
            
        case .didTapSignUpButton:
            let moveToSignUp: Observable<Mutation> = .just(.move(to: .signUp))
            return moveToSignUp
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateID(let id):
            newState.id = id
            newState.canTrySignIn = self.verify(id: id, password: state.password)
            
        case .updatePassword(let password):
            newState.password = password
            newState.canTrySignIn = self.verify(id: state.id, password: password)
            
        case .updateLoading(let isLoading):
            newState.isLoading = isLoading
            
        case .move(let step):
            newState.step = step
            
        case .occurError(let error):
            newState.occuredError = error
            newState.alertMessage = self.messageOf(error: error)
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
        let idIsFulfill = id.count > 4
        let pwIsFulfill = password.count > 4
        return idIsFulfill && pwIsFulfill
    }
    
    private func messageOf(error: Error) -> String {
        #warning("Error의 메시지 로직 - Booung")
        return "sign in failure"
    }
    
    private let userSessionRepository: UserSessionRepository
    
}
