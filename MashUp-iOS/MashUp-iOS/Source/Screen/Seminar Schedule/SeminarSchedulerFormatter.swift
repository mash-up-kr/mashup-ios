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

final class SeminarSchedulerFormatterImpl: SeminarSchedulerFormatter {
    
    func formatSection(
        from seminars: [Seminar],
        onLoadingPage: Bool
    ) -> [SeminarSection] {
        let totalItems = seminars
            .map { SeminarCardCellModel(from: $0) }
            .map { SeminarSectionItem.upcoming($0) }
        return [
            SeminarSection(type: .upcoming, items: totalItems)
        ]
    }
    
}
