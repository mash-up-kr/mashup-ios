//
//  ClubActivityService.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/07/09.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import RxSwift
import Foundation
import MashUp_User

protocol ClubActivityRepository {
    func totalClubActivityScore() -> Observable<ClubActivityScore>
    func histories(generation: Generation) -> Observable<[ClubActivityHistory]>
}

protocol ClubActivityService {
    func totalClubActivityScore() -> Observable<ClubActivityScore>
    func histories(generation: Generation) -> Observable<[ClubActivityHistory]>
}

final class ClubActivityServiceImp: ClubActivityService {
    
    init(clubActivityRepository: any ClubActivityRepository) {
        self.clubActivityRepository = clubActivityRepository
    }
    
    func totalClubActivityScore() -> Observable<ClubActivityScore> {
        return self.clubActivityRepository.totalClubActivityScore()
    }
    
    func histories(generation: Generation) -> Observable<[ClubActivityHistory]> {
        return self.clubActivityRepository.histories(generation: generation)
    }
    
    private let clubActivityRepository: any ClubActivityRepository
    
}
