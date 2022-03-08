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
extension SeminarCardCellModel {
    init(from seminar: Seminar) {
        let dateFormatter = DateFormatter().then {
            $0.dateFormat = "M월 d일 (E)"
            $0.timeZone = .UTC
            $0.locale = .ko_KR
        }
        self.init(
            title: seminar.title,
            summary: seminar.summary,
            dday: ["오늘", "D-1", "D-2"].randomElement()!,
            date: dateFormatter.string(from: seminar.date),
            time: "오후 3시 30분 - 오후 4시 30분",
            attendance: .allCases.randomElement()!
        )
    }
}
