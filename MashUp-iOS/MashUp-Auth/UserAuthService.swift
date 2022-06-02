//
//  UserAuthService.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/24.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxSwift

public protocol UserAuthService {
    func autoSignIn() -> Observable<UserSession?>
    func signIn(id: String, password: String) -> Observable<UserSession>
    func signUp(with newAccount: NewAccount) -> Observable<UserSession>
}
