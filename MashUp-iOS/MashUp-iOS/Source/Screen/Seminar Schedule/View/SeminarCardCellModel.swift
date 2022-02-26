//
//  SeminarCardCellModel.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/27.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

enum AttendanceStyle: String, Equatable, Hashable, CaseIterable {
    case attend
    case absence
    case lateness
    case upcoming
    
    var title: String {
        switch self {
        case .attend: return "출석"
        case .absence: return "결석"
        case .lateness: return "지각"
        case .upcoming: return "출석예정"
        }
    }
    
    var color: UIColor {
        switch self {
        case .attend: return UIColor.systemGreen
        case .absence: return UIColor.systemRed
        case .lateness: return UIColor.systemOrange
        case .upcoming: return UIColor.systemGray
        }
    }
}

struct SeminarCardCellModel: Equatable, Hashable {
    let title: String
    let summary: String
    let dday: String
    let date: String
    let time: String
    let attendance: AttendanceStyle
}
