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
    case signUpCode(account: NewAccount)
}

final class SignUpStep2Reactor: Reactor {
    
    typealias Step = SignUpStep2Step
    
    enum Action {
        case didEditNameField(String)
        case didTapSelectControl
        case didSelectPlatformTeam(at: Int)
        case didTapDone
    }
    
    enum Mutation {
        case updateName(String)
        case updateShowMenu
        case updateSelectedPlatformTeam(PlatformTeam)
        case move(to: Step)
    }
    
    struct State {
        var canDone: Bool = false
        var name: String = .empty
        var selectedPlatformTeam: PlatformTeamMenuViewModel?
        
        @Pulse var shouldShowMenu: [PlatformTeamSelectViewModel]?
        @Pulse var step: Step?
        
        fileprivate let id: String
        fileprivate let password: String
        fileprivate var platformTeam: PlatformTeam?
    }
    
    let initialState: State
    
    init(id: String, password: String) {
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
            return .empty()
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
        }
        newState.canDone = newState.name.isNotEmpty && newState.selectedPlatformTeam != nil
        return newState
    }
}
