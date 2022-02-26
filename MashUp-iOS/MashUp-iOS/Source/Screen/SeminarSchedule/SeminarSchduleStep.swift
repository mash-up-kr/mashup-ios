//
//  SeminarSchduleStep.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

enum SeminarSchduleStep: Equatable {
    case qrScan
    case seminarDetail(seminarID: String)
}
