//
//  VerificationService.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/05/30.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

protocol VerificationService {
    func verify(id: String) -> Bool
    func verify(password: String) -> Bool
    func verify(name: String) -> Bool
}

final class VerificationServiceImpl: VerificationService {
    
    func verify(id: String) -> Bool {
        return 4 <= id.count && id.count <= 15
        && id.allSatisfy { $0.isLetter }
    }
    
    func verify(password: String) -> Bool {
        return password.count >= 8
        && password.contains { $0.isNumber }
        && password.contains { $0.isLetter }
    }
    
    func verify(name: String) -> Bool {
        return name.count >= 2
    }
    
}
