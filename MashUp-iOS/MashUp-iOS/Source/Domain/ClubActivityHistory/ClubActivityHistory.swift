//
//  ClubActivityHistory.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/07/09.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

struct ClubActivityHistory {
    let id: String
    let activityTitle: String
    let changedScore: ClubActivityScore
    let appliedTotalScore: ClubActivityScore
    let date: Date
    let eventTitle: String
}
