//
//  String+.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/24.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

public typealias AccessToken = String

extension String {
    public static let empty = ""
    public var isNotEmpty: Bool { !isEmpty }
}
