//
//  SeminarDetailSection.swift
//  MashUp-iOS
//
//  Created by 이문정 on 2022/07/02.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxDataSources

enum SeminarDetailSectionType: Int, Equatable {
    case first
    case second
    
    var header: String {
        switch self {
        case .first: return "1부"
        case .second: return "2부"
        }
    }
    
}

struct SeminarDetailSection: Hashable {
    typealias Item = SeminarDetailCellModel
    
    let type: SeminarDetailSectionType
    let items: [Item]
}
