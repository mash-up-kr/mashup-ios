//
//  MembershipWithdrawalService.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/07/08.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import RxSwift

protocol MembershipWithdrawalService {
    func withdrawal() -> Observable<Bool>
}

final class MembershipWithdrawalServiceImpl: MembershipWithdrawalService {
    func withdrawal() -> Observable<Bool> {
        return .empty()
    }
}
