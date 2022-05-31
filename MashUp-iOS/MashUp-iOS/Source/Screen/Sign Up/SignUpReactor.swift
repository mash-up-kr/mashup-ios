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
        case updateShouldSelectPlatform
    }
    
    struct State {
        var id: String = .empty
        var password: String = .empty
        var name: String = .empty
        var selectedPlatform: PlatformTeam? = nil
        
        var canDone: Bool = false
        var hasVaildatedID: Bool? = nil
        var hasVaildatedPassword: Bool? = nil
        var hasAgreedTerms: Bool = false
        
        @Pulse var shouldSelectPlatform: [PlatformTeam]?
        @Pulse var shouldAgreeTerms: Void?
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
            return .just(.updateShouldSelectPlatform)
            
        case .didSelectPlatform(let index):
            let updateSelectedPlatform = self.platformService.allPlatformTeams()
                .compactMap { $0[safe: index] }
                .map { Mutation.updatePlatform($0) }
                .catch { _ in .empty() }
            return updateSelectedPlatform
            
        case .didTapDoneButton:
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
            
        case .updateName(let name):
            newState.name = name
            
        case .updatePlatform(let platform):
            newState.selectedPlatform = platform
            
        case .updateShouldSelectPlatform:
            #warning("PlatformTeam 레퍼지토리 로드로 변경 - Booung")
            newState.shouldSelectPlatform = PlatformTeam.allCases
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
