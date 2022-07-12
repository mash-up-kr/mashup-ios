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
    
    var header: String {
        switch self {
        case .upcoming: return "다음 세미나 일정까지\n12일 남았습니다."
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
}
