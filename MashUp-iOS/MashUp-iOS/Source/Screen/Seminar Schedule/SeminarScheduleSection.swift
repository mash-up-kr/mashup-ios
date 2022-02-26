//
//  SeminarScheduleSection.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxDataSources

enum SeminarScheduleSection {
    case upcoming(items: [Item])
    case total(items: [Item])
}
extension SeminarScheduleSection: SectionModelType, Equatable {
    typealias Item = SeminarSchedulerSectionItem
    
    var header: String {
        switch self {
        case .upcoming:
            return "다가오는 일정을 체크하세요 🤓"
        case .total:
            return "전체 일정 리스트"
        }
    }
    
    var items: [SeminarSchedulerSectionItem] {
        switch self {
        case .upcoming(let items),
                .total(let items):
            return items
        }
    }
    
    init(original: SeminarScheduleSection, items: [SeminarSchedulerSectionItem]) {
        switch original {
        case .upcoming:
            self = .upcoming(items: items)
        case .total:
            self = .total(items: items)
        }
    }
}

enum SeminarSchedulerSectionItem: Equatable {
    
}


