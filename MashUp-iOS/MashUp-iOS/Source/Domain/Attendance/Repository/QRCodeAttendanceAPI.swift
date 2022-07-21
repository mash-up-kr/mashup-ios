//
//  QRAttendanceAPI.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/07/20.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_Network

struct QRCodeAttendanceAPI {
    let code: Code
}
extension QRCodeAttendanceAPI: MashUpAPI {
    var path: String { "/api/v1/attendance/check/\(self.code)" }
    var headers: [String : String]? { nil }
    var httpMethod: HTTPMethod { .post }
    var httpTask: HTTPTask { .requestPlain }
}
extension QRCodeAttendanceAPI {
    struct Response: Decodable {
        let status: AttendanceStatusEntity
    }
}
