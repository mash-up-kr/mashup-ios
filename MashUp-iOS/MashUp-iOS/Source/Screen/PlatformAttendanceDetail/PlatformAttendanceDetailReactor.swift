//
//  SeminarDetailReactor.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/03/16.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import ReactorKit
import MashUp_PlatformTeam

final class PlatformAttendanceDetailReactor: Reactor {
    enum Action {
        case didSetup
    }
    
    enum Mutation {
        case updateLoading(Bool)
        case updateMembers([AttendanceMember])
        case occurError(Error)
    }
    
    struct State {
        var isLoading: Bool = false
        var members: [AttendanceMember] = []
        var platform: PlatformTeam
        var navigationTitle: String
        @Pulse var error: Error?
    }
    
    let initialState: State
    private let attendanceService: AttendanceService
    
    init(attendanceService: AttendanceService, platform: PlatformTeam) {
        self.initialState = State(platform: platform,
                                  navigationTitle: "\(platform)(0명)")
        self.attendanceService = attendanceService
    }
    
    // MARK: - Mutate
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didSetup:
            let startLoading: Observable<Mutation> = .just(.updateLoading(true))
//            let loadMember: Observable<Mutation> = attendanceService.attendanceMembers(platform: currentState.platform)
//                .map { .updateMembers($0) }
            let mockMemeber: Observable<Mutation> = .just(.updateMembers(AttendanceMember.dummy))
            let endLoading: Observable<Mutation> = .just(.updateLoading(false))
            
            return .concat(startLoading, mockMemeber, endLoading)
                .catch { error in .concat(.just(.occurError(error)), endLoading) }
        }
    }
    
    // MARK: - Reduce
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateLoading(let isLoading):
            newState.isLoading = isLoading
        case .updateMembers(let members):
            newState.members = members
            newState.navigationTitle = "\(newState.platform)(\(members.count)명)"
        case .occurError(let error):
            newState.error = error
        }
        return newState
    }
}
