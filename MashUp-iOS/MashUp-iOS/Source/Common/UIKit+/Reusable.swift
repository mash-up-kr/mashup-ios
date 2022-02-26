//
//  ReusableCell.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/27.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

protocol Reusable {
    static var reuseIdentifier: String { get }
}
extension Reusable {
    static var reuseIdentifier: String { "\(type(of: self))" }
}
