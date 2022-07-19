//
//  UserAuthServiceImp.swift
//  MashUp-Auth
//
//  Created by Booung on 2022/07/14.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_User
import RxSwift

enum SignInError: String, Error {
    case idError = "MEMBER_NOT_FOUND"
    case passwordError = "MEMBER_NOT_MATCH_PASSWORD"
}

protocol UserSessionRepository {
    func signIn(id: String, password: String) -> Observable<UserSession>
    func signUp(with newAccount: NewAccount, signUpCode: String) -> Observable<UserSession>
}

final class UserAuthServiceImp: UserAuthService {
    
    init(userSessionRepository: any UserSessionRepository) {
        self.userSessionRepository = userSessionRepository
    }
    
    func autoSignIn() -> Observable<UserSession?> {
        return .just(nil)
    }
    
    func signIn(id: String, password: String) -> Observable<UserSession> {
        return .empty()
//        do {
//            let userSession = try await self.userSessionRepository.signIn(id: id, password: password)
//                .asSingle()
//                .value
//            return .success(userSession)
//        } catch let signUpError as SignUpError {
//            return .failure(signUpError)
//        } catch {
//            return .failure(.undefined)
//        }
    }
    
    func signUp(with newAccount: NewAccount, signUpCode: String) async -> Result<UserSession, SignUpError> {
        do {
            let userSession = try await self.userSessionRepository.signUp(with: newAccount, signUpCode: signUpCode)
                .asSingle()
                .value
            return .success(userSession)
        } catch let signUpError as SignUpError {
            return .failure(signUpError)
        } catch {
            return .failure(.undefined)
        }
    }
    
    func signOut() -> Observable<Bool> {
        return .empty()
    }
    
    private let userSessionRepository: any UserSessionRepository
    
}
