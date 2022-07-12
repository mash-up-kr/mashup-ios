//
//  InternalError.swift
//  MashUp-Network
//
//  Created by Booung on 2022/07/12.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_Core

enum InternalError: String, Error {
    case badRequest = "BAD_REQUEST"                    // 요청에 오류가 있습니다.
    case unauthorized = "UNAUTHORIZED"                 // 인증이 필요한 요청입니다.
    case forbidden = "FORBIDDEN"                       // 허용되지 않은 접근입니다.
    case notFound = "NOT_FOUND"                        // 대상이 존재하지 않습니다.
    case internalServerError = "INTERNAL_SERVER_ERROR" // 서버에 오류가 발생했습니다. 잠시 후 다시 시도해주세요.
    case unknown
}

extension MashUpError {
    func asInternalError() -> InternalError? {
        return InternalError(rawValue: self.code)
    }
}
