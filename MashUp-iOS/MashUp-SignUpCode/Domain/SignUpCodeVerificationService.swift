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
        AsyncStream(Result<Void, SignUpCodeError>.self) { continuation in
            Task.detached {
                let result = await self.verify(signUpCode: signUpCode)
                continuation.yield(result)
                continuation.finish()
            }
        }.asObservable()
    }
    
}

