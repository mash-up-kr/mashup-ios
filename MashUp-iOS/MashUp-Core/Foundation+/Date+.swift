//
//  Date+.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/27.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import Then

extension Date {
    public init(
        year: Int = 1970,
        month: Int = 1,
        day: Int = 1,
        hour: Int = 0,
        minute: Int = 0,
        second: Int = 0
    ) {
        let dateString = "\(year)-\(month)-\(day) \(hour):\(minute):\(second)"
        self = Date.dateFormatter.date(from: dateString)!
    }
    
    private static let dateFormatter = DateFormatter().then {
        $0.dateFormat = "yyyy-MM-dd HH:mm:ss"
        $0.timeZone = .UTC
    }
    
    public static func now() -> Date {
        Date()
    }
}
