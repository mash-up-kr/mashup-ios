//
//  SeminarSchedulerFormatter.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/03/19.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

protocol SeminarSchedulerFormatter {
    func formatSection(from seminars: [Seminar], onLoadingPage: Bool) -> [SeminarSection]
}

class SeminarSchedulerFormatterImpl: SeminarSchedulerFormatter {
    func formatSection(
        from seminars: [Seminar],
        onLoadingPage: Bool
    ) -> [SeminarSection] {
        let upcomingItems = seminars.prefix(3)
            .map { SeminarCardCellModel(from: $0) }
            .map { SeminarSectionItem.upcoming($0) }
        let totalItems = seminars
            .map { SeminarCardCellModel(from: $0) }
            .map { SeminarSectionItem.total($0) }
        return [
            SeminarSection(type: .upcoming, items: upcomingItems),
            SeminarSection(type: .total, items: totalItems)
        ]
    }
}
