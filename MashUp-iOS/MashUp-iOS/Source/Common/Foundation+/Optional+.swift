//
//  Optional+.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/03/08.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

extension Optional where Wrapped == Bool {
    
    public var isFalseOrNil: Bool {
        self == nil || self == false
    }
    
    public var isTrueOrNil: Bool {
        self == nil || self == true
    }
    
}

extension Optional where Wrapped: Collection {
    
    public var isEmptyOrNil: Bool {
        self == nil || self?.isEmpty == true
    }
    
    public var isNotEmptyOrNil: Bool {
        self == nil || self?.isNotEmpty == true
    }
    
}

extension Optional where Wrapped == String {
    
    public var isEmptyOrNil: Bool {
        self == nil || self?.isEmpty == true
    }
    
    public var isNotEmptyOrNil: Bool {
        self == nil || self?.isNotEmpty == true
    }
    
}
