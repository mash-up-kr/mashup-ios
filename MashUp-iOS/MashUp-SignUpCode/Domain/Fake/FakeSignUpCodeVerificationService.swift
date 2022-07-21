//
//  FakeSignUpCodeVerificationService.swift
//  MashUp-SignUpCode
//
//  Created by Booung on 2022/06/03.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

public final class FakeSignUpCodeVerificationService: SignUpCodeVerificationService {
    
    public init() {}
    
    public var correctCode: String?
    
    public func verify(signUpCode: String) async -> Result<Void, SignUpCodeError> {
        guard signUpCode == self.correctCode else { return .failure(.wrongCode) }
        
        return .success(Void())
    }
    
}
