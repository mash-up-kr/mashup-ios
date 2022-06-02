//
//  NetworkError.swift
//  MashUp-Network
//
//  Created by Booung on 2022/06/02.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import Moya

public enum NetworkError: Error {
    case moyaError(MoyaError)
    case decodeFailure(DecodingError)
    case undefined(Error)
}
