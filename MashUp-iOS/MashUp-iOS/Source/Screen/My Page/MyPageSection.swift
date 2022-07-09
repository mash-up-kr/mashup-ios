//
//  MyPageSection.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/07/08.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

enum MyPageSection: Hashable {
    typealias TitleHeader = AttendanceHistoryTitleHeaderModel
    typealias HistoryHeader = AttendanceHistorySectionHeaderModel
    typealias Item = MyPageSectionItem
    
    case title(TitleHeader)
    case historys(HistoryHeader, items: [Item])
    case empty
}

enum MyPageSectionItem: Hashable {
    case history(AttendanceScoreHistoryCellModel)
}
