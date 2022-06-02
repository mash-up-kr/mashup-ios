//
//  SignUpCodeReactor.swift
//  MashUp-SignUpCode
//
//  Created by Booung on 2022/06/03.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import ReactorKit

final class SignUpCodeReactor: Reactor {
    
    enum Action {
        
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
    }
    
    let initialState: State = State()
    
    init(signUpCodeVerificationService: any SignUpCodeVerificationService) {
        self.signUpCodeVerificationService = signUpCodeVerificationService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        .empty()
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        state
    }
    
    private let signUpCodeVerificationService: any SignUpCodeVerificationService
    
}
