//
//  AttendanceStatusRectangleViewModel.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/05/27.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

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
        case .attend: return .green
        case .absence: return .red
        case .lateness: return .orange
        }
    }
    
    var backgroundColor: UIColor {
        switch status {
        case .attend: return .green.withAlphaComponent(0.5)
        case .absence: return .red.withAlphaComponent(0.5)
        case .lateness: return .orange.withAlphaComponent(0.5)
        }
    }
}
