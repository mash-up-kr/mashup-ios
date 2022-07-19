//
//  UserSessionRepository.swift
//  MashUp-Auth
//
//  Created by Booung on 2022/07/14.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_Network
import MashUp_User
import MashUp_PlatformTeam
import RxSwift

final class UserSessionRepositoryImp: UserSessionRepository {
    
    init(network: any Network) {
        self.network = network
    }
    
    func signIn(id: String, password: String) -> Observable<UserSession> {
        let api = SignInAPI(id: id, password: password)
        
        return self.network.request(api)
            .map { try $0.get() }
            .withUnretained(self)
            .map { owner, entity in
                owner.translate(id: id, user: entity)
            }
    }
    
    func signUp(with newAccount: NewAccount, signUpCode: String) -> Observable<UserSession> {
        let api = SignUpAPI(
            id: newAccount.id,
            name: newAccount.name,
            password: newAccount.password,
            platform: newAccount.platform.rawValue,
            signUpCode: signUpCode
        )
        
        #warning("회원가입시에도 유저 정보 내려오게 요청 '수정 필요' - booung")
        return self.network.request(api)
            .withUnretained(self)
            .flatMapFirst { owner, _ in
                owner.signIn(id: newAccount.id, password: newAccount.password)
            }
    }
    
    private func translate(newAccount: NewAccount, accessToken: String) -> UserSession {
        return UserSession(
            id: newAccount.id, userID: 0,
            accessToken: accessToken,
            name: newAccount.name,
            platformTeam: newAccount.platform,
            generations: []
        )
    }
    
    private func translate(id: String, user: SignInResponse) -> UserSession {
        return UserSession(
            id: id,
            userID: user.userID,
            accessToken: user.accessToken,
            name: user.userName,
            platformTeam: PlatformTeam(rawValue: user.platform) ?? .iOS,
            generations: [12]
        )
    }
    
    private let network: any Network
    
}
