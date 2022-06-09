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
        case didTapPlatformSelectControl
        case didSelectPlatform(at: Int)
        case didTapDoneButton
    }
    
    enum Mutation {
        case updateID(String)
        case updatePassword(String)
        case updatePasswordCheck(String)
        case updatePlatform(PlatformTeam)
        case showOnBottomSheet([PlatformTeam])
        case showPolicyAgreementStatus(Bool)
    }
    
    struct State {
        var id: String = .empty
        var password: String = .empty
        var passwordCheck: String = .empty
        var selectedPlatform: PlatformTeam?
        
        var canDone: Bool = false
        var hasVaildatedID: Bool?
        var hasVaildatedPassword: Bool?
        var hasVaildatedPasswordCheck: Bool?
        var hasAgreedPolicy: Bool = false
        
        @Pulse var shouldShowOnBottomSheet: [PlatformTeam]?
        @Pulse var shouldShowPolicyAgreementStatus: Bool?
    }
    
    let initialState: State = State()
    
    init(
        platformService: any PlatformService,
        verificationService: any VerificationService
    ) {
        self.platformService = platformService
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
            
        case .didTapPlatformSelectControl:
            let showOnBottomSheet = self.platformService.allPlatformTeams()
                .map { Mutation.showOnBottomSheet($0) }
                .catch { _ in .empty() }
            #warning("구체 에러 핸들링 정의 - booung")
            return showOnBottomSheet
            
        case .didSelectPlatform(let index):
            guard let selectedPlatform = self.currentState.shouldShowOnBottomSheet?[safe: index] else { return .empty() }
            return .just(.updatePlatform(selectedPlatform))
            
        case .didTapDoneButton:
            let policyAgreementStatus = self.currentState.hasAgreedPolicy
            return .just(.showPolicyAgreementStatus(policyAgreementStatus))
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
            
        case .updatePlatform(let platform):
            newState.selectedPlatform = platform
        
        case .showPolicyAgreementStatus(let agree):
            newState.shouldShowPolicyAgreementStatus = agree
            
        case .showOnBottomSheet(_):
            ()
        }
        newState.canDone = newState.hasVaildatedID == true
        && newState.hasVaildatedPassword == true
        && newState.hasVaildatedPasswordCheck == true
        return newState
    }
    
    private let platformService: any PlatformService
    private let verificationService: any VerificationService
    
}
