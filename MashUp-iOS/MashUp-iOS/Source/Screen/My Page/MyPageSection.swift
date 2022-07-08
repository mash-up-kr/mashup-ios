//
//  MyPageSection.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/07/08.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

enum MyPageSection {
    case title
    case history(generation: Generation, items: [AttendanceScoreHistoryCellModel])
}
