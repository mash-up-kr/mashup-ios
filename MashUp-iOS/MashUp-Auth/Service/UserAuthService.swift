//
//  UserAuthService.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/24.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_User
import RxSwift

public protocol UserAuthService {
    func autoSignIn() -> Observable<UserSession?>
    func signIn(id: String, password: String) -> Observable<UserSession>
    func signUp(with newAccount: NewAccount, signUpCode: String) async -> Result<UserSession, SignUpError>
    func signUp(with newAccount: NewAccount, signUpCode: String) -> Observable<Result<UserSession, SignUpError>>
    func signOut() -> Observable<Bool>
}
public extension UserAuthService {
    func signUp(with newAccount: NewAccount, signUpCode: String) -> Observable<Result<UserSession, SignUpError>> {
        return AsyncStream { await signUp(with: newAccount, signUpCode: signUpCode) }.asObservable()
    }
}
