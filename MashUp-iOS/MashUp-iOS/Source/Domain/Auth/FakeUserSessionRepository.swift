//
//  FakeUserSessionRepository.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/25.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxSwift

class FakeUserSessionRepository: UserSessionRepository  {
    var stubedUserSession: UserSession?
    
    func load() -> Observable<UserSession?> {
        return .just(self.stubedUserSession)
    }
    
    func signIn(id: String, password: String) -> Observable<UserSession> {
        guard let userSession = self.stubedUserSession else { return .empty() }
        
        return .just(userSession)
    }
    
    func signUp(with newAccount: NewAccount) -> Observable<UserSession> {
        guard let userSession = self.stubedUserSession else { return .empty() }
        
        return .just(userSession)
    }
}
