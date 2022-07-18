//
//  SettingReactor.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/07/18.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxSwift
import ReactorKit
import MashUp_Auth

enum SettingStep: Equatable {
    case withdrawal
    case open(URL)
}

final class SettingReactor: Reactor {
    
    enum Action {
        case didTapSignOut
        case didTapWithdrawal
        case didTapFacebook
        case didTapInstagram
        case didTapTistory
        case didTapYoutube
        case didTapHomepage
        case didTapRecruit
        case didConfirmSignOut
        case didTapBack
    }
    
    enum Mutation {
        case updateLoading(Bool)
        case askSignOut
        case signedOut
        case goBackward
        case moveTo(SettingStep)
    }
    
    struct State {
        var isLoading: Bool = false
        
        @Pulse var shouldGoBackward: Void?
        @Pulse var askUserToSignOut: Void?
        @Pulse var step: SettingStep?
    }
    
    let initialState: State = State()
    
    init(
        userAuthService: any UserAuthService,
        authenticationResponder: any AuthenticationResponder
    ) {
        self.userAuthService = userAuthService
        self.authenticationResponder = authenticationResponder
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didTapSignOut:
            return .just(.askSignOut)
            
        case .didTapWithdrawal:
            return .just(.moveTo(.withdrawal))
            
        case .didTapFacebook:
            guard let facebookURL = URL(string: "https://www.facebook.com") else { return .empty() }
            return .just(.moveTo(.open(facebookURL)))
            
        case .didTapInstagram:
            guard let instagramURL = URL(string: "https://www.instagram.com") else { return .empty() }
            return .just(.moveTo(.open(instagramURL)))
            
        case .didTapTistory:
            guard let tistoryURL = URL(string: "https://www.tistory.com") else { return .empty() }
            return .just(.moveTo(.open(tistoryURL)))
            
        case .didTapYoutube:
            guard let youtubeURL = URL(string: "https://www.youtube.com") else { return .empty() }
            return .just(.moveTo(.open(youtubeURL)))
            
        case .didTapHomepage:
            guard let webPageURL = URL(string: "https://mash-up.kr") else { return .empty() }
            return .just(.moveTo(.open(webPageURL)))
            
        case .didTapRecruit:
            guard let recruitURL = URL(string: "https://recruit.mash-up.kr") else { return .empty() }
            return .just(.moveTo(.open(recruitURL)))
            
        case .didConfirmSignOut:
            let startLoading: Observable<Mutation> = .just(.updateLoading(true))
            let signOut: Observable<Mutation> = self.userAuthService.signOut()
                .filter { $0 }
                .map { _ in .signedOut }
            let endLoading: Observable<Mutation> = .just(.updateLoading(false))
            return .concat(startLoading, signOut, endLoading)
            
        case .didTapBack:
            return .just(.goBackward)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateLoading(let isLoading):
            newState.isLoading = isLoading
        case .askSignOut:
            newState.askUserToSignOut = Void()
        case .signedOut:
            self.authenticationResponder.signOutSuccess()
        case .goBackward:
            newState.shouldGoBackward = Void()
        case .moveTo(let step):
            newState.step = step
        }
        return newState
    }
    
    private let userAuthService: any UserAuthService
    private let authenticationResponder: any AuthenticationResponder
}
