//
//  SeminarDetailCellModel.swift
//  MashUp-iOS
//
//  Created by 이문정 on 2022/07/02.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

struct SeminarDetailCellModel: Equatable, Hashable {
    let title: String
    let platform: String
    let time: String
}
extension SeminarDetailCellModel {
    init(from seminar: Seminar) {
        self.init(
            title: "안드로이드 팀 세미나",
            platform: "Android Crew",
            time: "AM 11:00"
        )
    }
}
