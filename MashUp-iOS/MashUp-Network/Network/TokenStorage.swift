//
//  TokenStorage.swift
//  MashUp-Network
//
//  Created by Booung on 2022/07/20.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

public protocol TokenStorage {
    var accessToken: String? { get set }
}

#warning("싱글턴 제거 되어야합니다 - booung")
final class TokenStorageImp: TokenStorage {
    public static var shared = TokenStorageImp()
    
    public var accessToken: String?
}
