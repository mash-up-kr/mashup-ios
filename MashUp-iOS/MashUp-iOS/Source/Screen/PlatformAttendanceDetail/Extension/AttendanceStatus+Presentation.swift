//
//  AttendanceStatus+Presentation.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/06/09.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

extension AttendanceStatus {
    var title: String {
        switch self {
        case .attend: return "출석"
        case .absence: return "결석"
        case .lateness: return "지각"
        }
    }
    
    var color: UIColor {
        switch self {
        case .attend: return UIColor.green
        case .absence: return UIColor.systemRed
        case .lateness: return UIColor.systemOrange
        }
    }
}
