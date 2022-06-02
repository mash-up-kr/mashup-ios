//
//  Collection+.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

extension Array {
    public subscript (safe index: Index) -> Element? {
        guard self.indices.contains(index) else { return nil }
        return self[index]
    }
}

extension Collection {
    public var isNotEmpty: Bool { !self.isEmpty }
}
