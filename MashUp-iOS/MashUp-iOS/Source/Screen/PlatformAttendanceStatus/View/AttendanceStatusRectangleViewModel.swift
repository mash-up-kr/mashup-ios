//
//  AttendanceStatusRectangleViewModel.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/05/27.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_UIKit

struct AttendanceStatusRectangleViewModel {
    let status: AttendanceStatus
    let count: Int
    
    var title: String {
        switch status {
        case .attend: return "출석"
        case .absence: return "결석"
        case .lateness: return "지각"
        }
    }
    
    var titleColor: UIColor {
        switch status {
        case .attend: return .green500
        case .absence: return .red500
        case .lateness: return .yellow500
        }
    }
    
    var backgroundColor: UIColor {
        switch status {
        case .attend: return .green100
        case .absence: return .red100
        case .lateness: return .yellow100
        }
    }
    
    var image: UIImage? {
        UIImage(systemName: "heart")
    }
}
