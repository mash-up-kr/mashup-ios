//
//  Optional+.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/03/08.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

extension Optional where Wrapped == Bool {
    
    var isFalseOrNil: Bool {
        self == nil || self == false
    }
    
    var isTrueOrNil: Bool {
        self == nil || self == true
    }
    
}

extension Optional where Wrapped: Collection {
    
    var isEmptyOrNil: Bool {
        self == nil || self?.isEmpty == true
    }
    
    var isNotEmptyOrNil: Bool {
        self == nil || self?.isNotEmpty == true
    }
    
}
