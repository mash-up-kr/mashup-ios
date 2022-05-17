//
//  SeminarRepository.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/27.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxSwift

protocol SeminarRepository {
    func nearestSeminar() -> Observable<Seminar>
    func fetchSeminars() -> Observable<[Seminar]>
}

final class SeminarRepositoryImpl: SeminarRepository {
    
    func nearestSeminar() -> Observable<Seminar> {
        .empty()
    }
    
    func fetchSeminars() -> Observable<[Seminar]> {
        return .empty()
    }
}
