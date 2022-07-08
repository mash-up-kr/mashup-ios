//
//  Generation.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/07/08.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

#warning("모듈 재비치 필요함 - booung")
struct Generation {
    let number: Int
}
extension Generation: ExpressibleByIntegerLiteral {
    init(integerLiteral value: Int) {
        self.number = value
    }
}
