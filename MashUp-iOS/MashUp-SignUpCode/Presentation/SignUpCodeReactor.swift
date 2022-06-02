//
//  SignUpCodeReactor.swift
//  MashUp-SignUpCode
//
//  Created by Booung on 2022/06/03.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import ReactorKit
import MashUp_Auth
import MashUp_User

final public class SignUpCodeReactor: Reactor {
    
    public enum Action {
        case didEditSignUpCodeField(String)
        case didTapDone
    }
    
    public enum Mutation {
        case updateLoading(Bool)
        case updateSignUpCode(String)
        case signedUp(UserSession)
        case occurCodeError(SignUpCodeError)
        case occurSignUpError(SignUpError)
    }
    
    public struct State {
        var isLoading: Bool = false
        var signUpCode: String = .empty
        var canDone: Bool = false
        
        fileprivate let userInProgress: NewAccount
    }
    
    public let initialState: State
    
    public init(
        userInProgress: NewAccount,
        signUpCodeVerificationService: any SignUpCodeVerificationService,
        userAuthService: any UserAuthService,
        authenticationResponder: any AuthenticationResponder
    ) {
        self.initialState = State(userInProgress: userInProgress)
        self.signUpCodeVerificationService = signUpCodeVerificationService
        self.userAuthService = userAuthService
        self.authenticationResponder = authenticationResponder
    }
    
    public func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didEditSignUpCodeField(let signUpCode):
            let trimmedSignUpCode = String(signUpCode.prefix(5))
            return .just(.updateSignUpCode(trimmedSignUpCode))
            
        case .didTapDone:
            let startLoading: Observable<Mutation> = .just(.updateLoading(true))
            let signUp: Observable<Mutation> = self.signUp()
            let endLoading: Observable<Mutation> = .just(.updateLoading(true))
            return .concat(startLoading, signUp, endLoading)
        }
    }
    
    public func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateLoading(let isLoading):
            newState.isLoading = isLoading
        case .updateSignUpCode(let signUpCode):
            newState.signUpCode = signUpCode
            newState.canDone = self.satisfy(signUpCode: signUpCode)
        case .signedUp(let userSession):
            self.authenticationResponder.loadSuccess(userSession: userSession)
        case .occurCodeError(let error):
            #warning("에러 핸들링 스펙 정의 필요 - Booung")
        case .occurSignUpError(let error):
            #warning("에러 핸들링 스펙 정의 필요 - Booung")
        }
        return newState
    }
    
    private func satisfy(signUpCode: String) -> Bool {
        return signUpCode.count == 5
    }
    
    private func signUp() -> Observable<Mutation> {
        let signUpCode = self.currentState.signUpCode
        let userInProgress = self.currentState.userInProgress
        
        return AsyncStream { [signUpCodeVerificationService, userAuthService] in
            let signUpCodeVerification = await signUpCodeVerificationService.verify(signUpCode: signUpCode)
            if case .failure(let codeError) = signUpCodeVerification { return Mutation.occurCodeError(codeError) }
            
            let signUp = await userAuthService.signUp(with: userInProgress)
            switch signUp {
            case .success(let userSession):
                return Mutation.signedUp(userSession)
            case .failure(let error):
                return Mutation.occurSignUpError(error)
            }
        }.asObservable()
    }
    
    private let signUpCodeVerificationService: any SignUpCodeVerificationService
    private let userAuthService: any UserAuthService
    private let authenticationResponder: any AuthenticationResponder
    
}
