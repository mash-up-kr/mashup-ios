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

final class ClubActivityRepositoryImp: ClubActivityRepository {
    
    init(network: Network = HTTPClient()) {
        self.network = network
    }
    
    func totalClubActivityScore() -> Observable<ClubActivityScore> {
        #warning("API 연동 - booung")
        return .empty()
    }
    
    func histories(generation: Generation) -> Observable<[ClubActivityHistory]> {
        #warning("API 연동 - booung")
        return .empty()
    }
    
    private let network: Network
    
}
