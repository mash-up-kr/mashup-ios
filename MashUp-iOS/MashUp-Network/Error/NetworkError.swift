//
//  NetworkError.swift
//  MashUp-Network
//
//  Created by Booung on 2022/06/02.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_Core

public enum NetworkError: Error {
    case cancelled
    case mashUpError(MashUpError)
    case undefined(Error)
}
