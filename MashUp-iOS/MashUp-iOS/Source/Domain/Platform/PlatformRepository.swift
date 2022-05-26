//
//  PlatformRepository.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/05/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxSwift

protocol PlatformRepository {
    func attendanceStatus() -> Observable<[PlatformAttendance]>
}

final class PlatformRepositoryImpl: PlatformRepository {
    func attendanceStatus() -> Observable<[PlatformAttendance]> {
        return .empty()
    }
}
