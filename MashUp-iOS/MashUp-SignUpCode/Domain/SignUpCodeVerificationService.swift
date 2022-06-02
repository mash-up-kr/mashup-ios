//
//  SignUpCodeVerificationService.swift
//  MashUp-SignUpCode
//
//  Created by Booung on 2022/06/03.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

public protocol SignUpCodeVerificationService {
    func verify(signUpCode: String) async -> Result<Void, SignUpCodeError>
}

