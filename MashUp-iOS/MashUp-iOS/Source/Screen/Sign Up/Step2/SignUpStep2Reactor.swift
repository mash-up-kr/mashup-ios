//
//  SignUpStep2Reactor.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/06/10.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import ReactorKit
import MashUp_PlatformTeam
import MashUp_User

enum SignUpStep2Step {
    case termsAgreement(NewAccount)
    case signUpCode(NewAccount)
}
protocol TermsAgreementResponder {
    func didAgreeTerms()
}
final class SignUpStep2Reactor: Reactor {
    
    typealias Step = SignUpStep2Step
    
    enum Action {
        case didEditNameField(String)
        case didTapSelectControl
        case didSelectPlatformTeam(at: Int)
        case didTapDone
        case didAgreeTerms
        case didTapBack
    }
    
    enum Mutation {
        case updateName(String)
        case updateShowMenu
        case updateSelectedPlatformTeam(PlatformTeam)
        case move(to: Step)
        case updateGoBack
    }
    
    struct State {
        var canDone: Bool = false
        var name: String = .empty
        var selectedPlatformTeam: PlatformTeamMenuViewModel?
        
        @Pulse var shouldShowMenu: [PlatformTeamSelectViewModel]?
        @Pulse var step: Step?
        @Pulse var shouldGoBack: Void?
        
        
        fileprivate let id: String
        fileprivate let password: String
        fileprivate var platformTeam: PlatformTeam?
    }
    
    let initialState: State
    
    init(
        id: String,
        password: String
    ) {
        self.initialState = State(id: id, password: password)
    }
     
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didEditNameField(let name):
            return .just(.updateName(name))
            
        case .didTapSelectControl:
            return .just(.updateShowMenu)
            
        case .didSelectPlatformTeam(let index):
            guard let menu = self.currentState.shouldShowMenu else { return .empty() }
            guard let platform = menu[safe: index]?.platform else { return .empty() }
            
            return .just(.updateSelectedPlatformTeam(platform))
            
        case .didTapDone:
            guard let platformTeam = self.currentState.platformTeam else { return .empty() }
            let newAccount = NewAccount(id: self.currentState.id,
                                        password: self.currentState.password,
                                        name: self.currentState.name,
                                        platform: platformTeam)
            return .just(.move(to: .termsAgreement(newAccount)))
            
        case .didAgreeTerms:
            guard let platformTeam = self.currentState.platformTeam else { return .empty() }
            
            let newAccount = NewAccount(
                id: self.currentState.id,
                password: self.currentState.password,
                name: self.currentState.name,
                platform: platformTeam
            )
            let step = Step.signUpCode(newAccount)
            return .just(.move(to: step))
            
        case .didTapBack:
            return .just(.updateGoBack)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateName(let name):
            newState.name = name
            
        case .updateShowMenu:
            newState.shouldShowMenu = PlatformTeam.allCases
                .map { PlatformTeamSelectViewModel(model: $0, isSelected: $0 == currentState.platformTeam) }
            
        case .updateSelectedPlatformTeam(let platformTeam):
            newState.platformTeam = platformTeam
            newState.selectedPlatformTeam = PlatformTeamMenuViewModel(model: platformTeam)
            
        case .move(let step):
            newState.step = step
            
        case .updateGoBack:
            newState.shouldGoBack = Void()
        }
        newState.canDone = newState.name.isNotEmpty && newState.selectedPlatformTeam != nil
        return newState
    }
    
}
extension SignUpStep2Reactor: TermsAgreementResponder {
    
    func didAgreeTerms() {
        self.action.onNext(.didAgreeTerms)
    }
    
}
