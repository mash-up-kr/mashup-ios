//
//  SignUpReactor.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/05/29.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import ReactorKit

final class SignUpReactor: Reactor {
    
    enum Action {
        case didEditIDField(String)
        case didEditPasswordField(String)
        case didEditNameField(String)
        case didTapPlatformSelectControl
        case didSelectPlatform(at: Int)
        case didTapDoneButton
    }
    
    enum Mutation {
        case updateID(String)
        case updatePassword(String)
        case updateName(String)
        case updatePlatform(PlatformTeam)
        case showOnBottomSheet([PlatformTeam])
        case showPolicyAgreementStatus(Bool)
    }
    
    struct State {
        var id: String = .empty
        var password: String = .empty
        var name: String = .empty
        var selectedPlatform: PlatformTeam?
        
        var canDone: Bool = false
        var hasVaildatedID: Bool?
        var hasVaildatedPassword: Bool?
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
            
        case .didEditNameField(let name):
            return .just(.updateName(name))
            
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
            
        case .updateName(let name):
            newState.name = name
            
        case .updatePlatform(let platform):
            newState.selectedPlatform = platform
            
        case .showOnBottomSheet(let platformTeams):
            newState.shouldShowOnBottomSheet = platformTeams
            
        case .showPolicyAgreementStatus(let agree):
            newState.shouldShowPolicyAgreementStatus = agree
        }
        newState.canDone = self.verify(id: newState.id,
                                       password: newState.password,
                                       name: newState.name,
                                       platform: newState.selectedPlatform)
        return newState
    }
    
    private func verify(id: String, password: String, name: String, platform: PlatformTeam?) -> Bool {
        return self.verificationService.verify(id: id)
        && self.verificationService.verify(password: password)
        && self.verificationService.verify(name: name)
        && platform != nil
    }
    
    private let platformService: any PlatformService
    private let verificationService: any VerificationService
    
}
