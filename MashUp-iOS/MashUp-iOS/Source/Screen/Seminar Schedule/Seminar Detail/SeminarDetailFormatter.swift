//
//  SeminarDetailFormatter.swift
//  MashUp-iOS
//
//  Created by 이문정 on 2022/07/02.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

protocol SeminarDetailFormatter {
    func formatSection(from seminars: [Seminar], onLoadingPage: Bool) -> [SeminarDetailSection]
}

final class SeminarDetailFormatterImpl: SeminarDetailFormatter {
    
    func formatSection(
        from seminars: [Seminar],
        onLoadingPage: Bool
    ) -> [SeminarDetailSection] {
        let firstSection = seminars.prefix(3)
            .map { SeminarDetailCellModel(from: $0) }
        let secondSection = seminars
            .map { SeminarDetailCellModel(from: $0) }
        return [
            SeminarDetailSection(type: .first, items: firstSection),
            SeminarDetailSection(type: .second, items: secondSection)
        ]
    }
    
}
