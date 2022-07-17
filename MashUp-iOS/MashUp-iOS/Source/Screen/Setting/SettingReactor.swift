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

enum SettingStep {
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
            guard let webPageURL = URL(string: "https://mash-up.kr/") else { return .empty() }
            return .just(.moveTo(.open(webPageURL)))
            
        case .didTapRecruit:
            guard let recruitURL = URL(string: "https://recruit.mash-up.kr/") else { return .empty() }
            return .just(.moveTo(.open(recruitURL)))
            
        case .didConfirmSignOut:
            let startLoading = Mutation.updateLoading(true)
            #warning("로그아웃 API 로직 구현 - booung")
            let endLoading = Mutation.updateLoading(false)
            return .empty()
            
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
        case .goBackward:
            newState.shouldGoBackward = Void()
        case .moveTo(let step):
            newState.step = step
        }
        return newState
    }
    
}
