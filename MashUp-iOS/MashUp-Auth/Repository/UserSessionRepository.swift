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
import RxSwift

final class UserSessionRepositoryImp: UserSessionRepository {
    
    init(network: any Network) {
        self.network = network
    }
    
    func signUp(with newAccount: NewAccount, signUpCode: String) -> Observable<UserSession> {
        let api = SignUpAPI(
            id: newAccount.id,
            name: newAccount.name,
            password: newAccount.password,
            signUpCode: signUpCode
        )
        
        return self.network.request(api)
            .map { try $0.get().accessToken }
            .withUnretained(self)
            .map { owner, accessToken in
                owner.translate(newAccount: newAccount, accessToken: accessToken)
            }
            .catch({ error in
                guard let networkError = error as? NetworkError,
                      let mashUpError = networkError.asMashUpError()
                else { return .error(error) }
                
                return .error(mashUpError.asSignUpError)
            })
    }
    
    private func translate(newAccount: NewAccount, accessToken: String) -> UserSession {
        return UserSession(
            id: newAccount.id,
            accessToken: accessToken,
            name: newAccount.name,
            platformTeam: newAccount.platform,
            generations: []
        )
    }
    
    private let network: any Network
    
}
