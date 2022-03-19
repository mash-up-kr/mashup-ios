//
//  QRSeminarCardViewModel.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/03/20.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

struct QRSeminarCardViewModel: Equatable {
    let title: String
    let dday: String
    let date: String
    let time: String
    let timeline: AttendanceTimelineViewModel?
}
