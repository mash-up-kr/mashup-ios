//
//  PlatformService.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/05/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxSwift

protocol PlatformService {
    func attendanceStatus() -> Observable<[PlatformAttendance]>
}

final class PlatformServiceImpl: PlatformService {
    private let repository: PlatformRepository
    
    init(repository: PlatformRepository) {
        self.repository = repository
    }
    
    func attendanceStatus() -> Observable<[PlatformAttendance]> {
        return repository.attendanceStatus()
    }
}
