//
//  SeminarScheduleSection.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxDataSources

enum SeminarSectionType: Int, Equatable {
    case upcoming
    case total
    
    var header: String {
        switch self {
        case .upcoming: return "다가오는 일정을 체크하세요🤓"
        case .total: return "전체 일정 리스트"
        }
    }
    
}

struct SeminarSection: Hashable {
    typealias Item = SeminarSectionItem
    
    let type: SeminarSectionType
    let items: [SeminarSectionItem]
}

enum SeminarSectionItem: Hashable {
    case upcoming(SeminarCardCellModel)
    case total(SeminarCardCellModel)
}
