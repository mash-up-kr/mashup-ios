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
    func totalClubActivityScore(ofUser user: UserSession) -> Observable<ClubActivityScore>
    func historys(generation: Generation, ofUser user: UserSession) -> Observable<[ClubActivityHistory]>
}

protocol ClubActivityService {
    func totalClubActivityScore(ofUser user: UserSession) -> Observable<ClubActivityScore>
    func historys(generation: Generation, ofUser user: UserSession) -> Observable<[ClubActivityHistory]>
}

final class ClubActivityServiceImp: ClubActivityService {
    
    init(clubActivityRepository: any ClubActivityRepository) {
        self.clubActivityRepository = clubActivityRepository
    }
    
    func totalClubActivityScore(ofUser user: UserSession) -> Observable<ClubActivityScore> {
        return self.clubActivityRepository.totalClubActivityScore(ofUser: user)
    }
    
    func historys(generation: Generation, ofUser user: UserSession) -> Observable<[ClubActivityHistory]> {
        return self.clubActivityRepository.historys(generation: generation, ofUser: user)
    }
    
    private let clubActivityRepository: any ClubActivityRepository
    
}
