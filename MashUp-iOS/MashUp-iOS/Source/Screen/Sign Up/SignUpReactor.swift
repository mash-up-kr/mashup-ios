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
        case didSelectPlatform(PlatformTeam)
        case didTapDoneButton
    }
    
    enum Mutation {
        case updateID(String)
        case updatePassword(String)
        case updateName(String)
        case updatePlatform(PlatformTeam)
    }
    
    struct State {
        var canDone: Bool = false
        var id: String = .empty
        var password: String = .empty
        var name: String = .empty
        var platform: PlatformTeam? = .iOS
        
        var hasVaildatedID: Bool? = nil
        var hasVaildatedPassword: Bool? = nil
        @Pulse var shouldAgreeTerms: Bool? = nil
    }
    
    let initialState: State = State()
    
    init(verificationService: VerificationService) {
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
            
        case .didSelectPlatform(let platform):
            return .just(.updatePlatform(platform))
            
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
            print("🐛 updateID \(id)")
            
        case .updatePassword(let password):
            newState.password = password
            newState.hasVaildatedPassword = self.verificationService.verify(password: password)
            print("🐛 updatePassword \(password)")
            
        case .updateName(let name):
            newState.name = name
            
        case .updatePlatform(let platform):
            newState.platform = platform
        }
        newState.canDone = self.verify(id: newState.id,
                                       password: newState.password,
                                       name: newState.name,
                                       platform: newState.platform)
        return newState
    }
    
    private func verify(id: String, password: String, name: String, platform: PlatformTeam?) -> Bool {
        return self.verificationService.verify(id: id)
        && self.verificationService.verify(password: password)
        && self.verificationService.verify(name: name)
        && platform != nil
    }
    
    private let verificationService: VerificationService
    
}
