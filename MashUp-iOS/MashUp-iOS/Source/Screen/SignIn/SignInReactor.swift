//
//  SignInReactor.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/24.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import RxSwift
import RxRelay
import ReactorKit

enum SignInStep {
    case home
}

final class SignInReactor: Reactor {
    
    enum Action {
        case didEditIDField(String)
        case didEditPasswordField(String)
        case didTapSignInButton
        case didTapSignUpButton
    }
    
    enum Mutation {
        case updateID(String)
        case updatePassword(String)
    }
    
    struct State {
        var id: String = .empty
        var password: String = .empty
        
    }
    
    let initialState: State = State()
    
}
