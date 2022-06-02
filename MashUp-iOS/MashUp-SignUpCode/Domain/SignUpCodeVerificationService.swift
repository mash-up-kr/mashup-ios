//
//  SignUpCodeVerificationService.swift
//  MashUp-SignUpCode
//
//  Created by Booung on 2022/06/03.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxSwift

public protocol SignUpCodeVerificationService {
    func verify(signUpCode: String) async -> Result<Void, SignUpCodeError>
    func verify(signUpCode: String) -> Observable<Result<Void, SignUpCodeError>>
}
public extension SignUpCodeVerificationService {
    
    func verify(signUpCode: String) -> Observable<Result<Void, SignUpCodeError>> {
        AsyncStream { await self.verify(signUpCode: signUpCode) }.asObservable()
    }
    
}

