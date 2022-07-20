//
//  PlatformStatusAPI.swift
//  MashUp-PlatformTeam
//
//  Created by 김남수 on 2022/07/19.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_Network

public struct PlatformAttendanceAPI: MashUpAPI {
    let scheduleID: Int
    
    public init(scheduleID: Int) {
        self.scheduleID = scheduleID
    }
}

extension PlatformAttendanceAPI {
    public typealias Response = PlatformAttendanceResponse?
    public var path: String { "/api/v1/attendance/platforms" }
    public var httpMethod: HTTPMethod { .get }
    public var httpTask: HTTPTask {
        let parameters: [String: Any] = [
            "scheduleId": scheduleID
        ]
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
    public var headers: [String : String]? { nil }
}
