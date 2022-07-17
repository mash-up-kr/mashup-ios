//
//  FakeUserAuthService.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/25.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxSwift
import MashUp_Core
import MashUp_User

public final class FakeUserAuthService: UserAuthService {
    
    public var stubedUserSession: UserSession?
    
    public init() {}
    
    public func autoSignIn() -> Observable<UserSession?> {
        return .just(self.stubedUserSession)
    }
    
    public func signIn(id: String, password: String) -> Observable<UserSession> {
        let isCorrectID = id.lowercased().contains("test")
        let isCorrectPW = password.lowercased().contains("test")
        
        guard isCorrectID, isCorrectPW else { return .error("sign in failure") }
        let fakeSession = UserSession(
            id: "fake.user.id",
            accessToken: "\(id).\(password)",
            name: "fake.name",
            platformTeam: .iOS,
            generations: [12]
        )
        
        return .just(fakeSession)
    }
    
    public func signUp(with newAccount: NewAccount) async -> Result<UserSession, SignUpError> {
        let isCorrectID = newAccount.id.lowercased().contains("test")
        let isCorrectPW = newAccount.password.lowercased().contains("test")
        
        guard isCorrectID, isCorrectPW else { return .failure(.undefined("sign in failure")) }
        let fakeSession = UserSession(
            id: "fake.user.id",
            accessToken: "\(newAccount.id).\(newAccount.password)",
            name: "fake.name",
            platformTeam: .iOS,
            generations: [12]
        )
        return .success(fakeSession)
    }
    
}
