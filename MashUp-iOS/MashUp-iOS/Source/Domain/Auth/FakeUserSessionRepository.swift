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
        let isCorrectID = id.lowercased().contains("test")
        let isCorrectPW = password.lowercased().contains("test")
        
        guard isCorrectID, isCorrectPW else { return .error("sign in failure") }
        let fakeSession = UserSession(id: "fake.user.id", accessToken: "\(id).\(password)")
        return .just(fakeSession)
    }
    
    func signUp(with newAccount: NewAccount) -> Observable<UserSession> {
        let isCorrectID = newAccount.id.lowercased().contains("test")
        let isCorrectPW = newAccount.password.lowercased().contains("test")
        
        guard isCorrectID, isCorrectPW else { return .error("sign in failure") }
        let fakeSession = UserSession(id: "fake.user.id", accessToken: "\(newAccount.id).\(newAccount.password)")
        return .just(fakeSession)
    }
}
