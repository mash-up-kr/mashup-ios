//
//  SeminarScheduleSection.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxDataSources

struct SeminarScheduleSection {
    var items: [Item]
}
extension SeminarScheduleSection: SectionModelType, Equatable {
    typealias Item = SeminarSchedulerSectionItem
    
    init(original: SeminarScheduleSection, items: [SeminarSchedulerSectionItem]) {
        self = original
        self.items = items
    }
}

enum SeminarSchedulerSectionItem: Equatable {
    
}

struct SeminarScheduleCellModel: Equatable {
    
}
