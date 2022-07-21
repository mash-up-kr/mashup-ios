//
//  MashUpError.swift
//  MashUp-Core
//
//  Created by Booung on 2022/07/12.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

public struct MashUpError: LocalizedError {
    
    public let code: String
    public let message: String
    
    public init(code: String, message: String) {
        self.code = code
        self.message = message
    }

}
