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
            .map { owner, userEntity in owner.translate(id: id, userEntity: userEntity) }
    }
    
    func signUp(with newAccount: NewAccount, signUpCode: String) -> Observable<UserSession> {
        let api = SignUpAPI(
            id: newAccount.id,
            name: newAccount.name,
            password: newAccount.password,
            platform: newAccount.platform.rawValue,
            signUpCode: signUpCode
        )
        
        return self.network.request(api)
            .map { try $0.get() }
            .withUnretained(self)
            .map { owner, userEntity in owner.translate(id: newAccount.id, userEntity: userEntity) }
    }
    
    private func translate(id: String, userEntity: UserEntity) -> UserSession {
        return UserSession(
            id: id,
            userID: userEntity.userID,
            accessToken: userEntity.accessToken,
            name: userEntity.userName,
            platformTeam: PlatformTeam(rawValue: userEntity.platform) ?? .iOS,
            generations: [Generation(integerLiteral: userEntity.generationNumber)]
        )
    }
    
    private let network: any Network
    
}
