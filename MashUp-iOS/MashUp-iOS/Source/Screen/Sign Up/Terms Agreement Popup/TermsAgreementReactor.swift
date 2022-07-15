//
//  TermsAgreementReactor.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/06/12.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxSwift
import ReactorKit
import MashUp_User

enum TermsAgreementStep {
    case personalPrivacyPolicy
}

final class TermsAgreementReactor: Reactor {
    
    enum Action {
        case didTapClose
        case didTapAcceptArea
        case didTapSeeMore
        case didTapConfirm
    }
    
    struct State {
        var canDone: Bool
        var hasAgreed: Bool
        
        @Pulse var shouldClose: Void?
        @Pulse var step: TermsAgreementStep?
        
        fileprivate let newAccount: NewAccount
    }
    
    let initialState: State
    
    init(
        newAccount: NewAccount,
        termsAgreementResponder: any TermsAgreementResponder
    ) {
        self.termsAgreementResponder = termsAgreementResponder
        self.initialState = State(
            canDone: false,
            hasAgreed: false,
            newAccount: newAccount
        )
    }
    
    func reduce(state: State, mutation: Action) -> State {
        var newState = state
        switch mutation {
        case .didTapClose:
            newState.shouldClose = Void()
            
        case .didTapAcceptArea:
            newState.hasAgreed = !state.hasAgreed
            newState.canDone = newState.hasAgreed
            
        case .didTapSeeMore:
            newState.hasAgreed = true
            newState.canDone = newState.hasAgreed
            newState.step = .personalPrivacyPolicy
            
        case .didTapConfirm:
            newState.shouldClose = Void()
            self.termsAgreementResponder.didAgreeTerms()
        }
        return newState
    }
 
    private let termsAgreementResponder: any TermsAgreementResponder
}
