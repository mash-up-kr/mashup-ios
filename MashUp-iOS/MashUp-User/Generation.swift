//
//  Generation.swift
//  MashUp-User
//
//  Created by Booung on 2022/07/10.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

public struct Generation: Equatable, Hashable {
    let number: Int
}
extension Generation: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self.number = value
    }
}
extension Generation: CustomStringConvertible {
    public var description: String { "\(number)기" }
}
extension Generation: Comparable {
    public static func < (lhs: Generation, rhs: Generation) -> Bool {
        return lhs.number < rhs.number
    }
}
