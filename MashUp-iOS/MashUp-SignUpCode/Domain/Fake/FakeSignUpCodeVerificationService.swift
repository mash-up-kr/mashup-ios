//
//  FakeSignUpCodeVerificationService.swift
//  MashUp-SignUpCode
//
//  Created by Booung on 2022/06/03.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

public final class FakeSignUpCodeVerificationService: SignUpCodeVerificationService {
    
    public var stubedResult: Result<Void, SignUpCodeError>?
    
    public func verify(signUpCode: String) async -> Result<Void, SignUpCodeError> {
        guard let result = self.stubedResult else { return .failure(.undefined("stub did not set")) }
        return result
    }
    
}
