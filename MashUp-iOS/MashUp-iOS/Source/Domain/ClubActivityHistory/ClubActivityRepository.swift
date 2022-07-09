//
//  ClubActivityRepository.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/07/09.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import RxSwift
import MashUp_User
import Foundation
import MashUp_Network

class ClubActivityRepositoryImp: ClubActivityRepository {
    
    init(network: Network = HTTPClient()) {
        self.network = network
    }
    
    func totalClubActivityScore(ofUser user: UserSession) -> Observable<ClubActivityScore> {
        #warning("API 연동 - booung")
        return .empty()
    }
    
    func historys(generation: Generation, ofUser user: UserSession) -> Observable<[ClubActivityHistory]> {
        #warning("API 연동 - booung")
        return .empty()
    }
    
    private let network: Network
    
}
