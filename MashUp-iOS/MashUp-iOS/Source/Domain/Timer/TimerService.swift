//
//  TimerService.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/03/19.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxSwift

protocol TimerService {
    func start(_ seconds: TimeInterval) -> Observable<TimeInterval>
}

final class TimerServiceImpl: TimerService {
    
    func start(_ seconds: TimeInterval) -> Observable<TimeInterval> {
        return Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .map { TimeInterval($0) }
            .map { seconds - $0 }
            .take(while: { $0 >= 0 })
    }
    
}
