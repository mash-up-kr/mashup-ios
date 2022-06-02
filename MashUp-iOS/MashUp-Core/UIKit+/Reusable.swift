//
//  ReusableCell.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/27.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

public protocol Reusable {
    static var reuseIdentifier: String { get }
}
extension Reusable {
    public static var reuseIdentifier: String { "\(type(of: self))" }
}
