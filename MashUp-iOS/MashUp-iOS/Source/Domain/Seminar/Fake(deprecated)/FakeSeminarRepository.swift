//
//  FakeSeminarRepository.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/03/02.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxSwift

final class FakeSeminarRepository: SeminarRepository {
    var stubedSeminars: [Seminar] = []
    
    func nearestSeminar() -> Observable<Seminar> {
        guard let seminar = stubedSeminars.first else { return .empty() }
        return .just(seminar)
    }
    
    func fetchSeminars() -> Observable<[Seminar]> {
        return .just(stubedSeminars)
    }
    
}
