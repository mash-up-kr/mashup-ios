//
//  SeminarDetailReactor.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/03/16.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import ReactorKit

final class SeminarDetailReactor: Reactor {
    enum Action {
        case didSelectedPlatform(at: Int)
    }
    
    enum Mutation {
        case updateLoading(Bool)
        case updateMembers([AttendanceMember])
        case updateSelectedPlatform(Int)
        case occurError(Error)
    }
    
    struct State {
        var isLoading: Bool = false
        var selectedPlatform: Int = 0
        var members: [AttendanceMember] = []
        var platforms: [PlatformCellModel] = PlatformCellModel.models
        @Pulse var error: Error?
    }
    
    let initialState: State = State()
    private let attendanceService: AttendanceService
    
    init(attendanceService: AttendanceService) {
        self.attendanceService = attendanceService
    }
    
    // MARK: - Mutate
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didSelectedPlatform(let index):
            let startLoading: Observable<Mutation> = .just(.updateLoading(true))
            let selectedPlatform: Observable<Mutation> = .just(.updateSelectedPlatform(index))
            let platform = platform(index: index)
            let loadMember: Observable<Mutation> = attendanceService.attendanceMember(platform: platform)
                .map { .updateMembers($0) }
            let endLoading: Observable<Mutation> = .just(.updateLoading(true))
            
            return .concat(startLoading, selectedPlatform, loadMember, endLoading)
                .catch { error in .concat(.just(.occurError(error)), endLoading) }
        }
    }
    
    private func platform(index: Int) -> PlatformTeam? {
        currentState.platforms[safe: index]?.platform
    }
    
    // MARK: - Reduce
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateLoading(let isLoading):
            newState.isLoading = isLoading
        case .updateMembers(let members):
            newState.members = members
        case .updateSelectedPlatform(let index):
            newState.selectedPlatform = index
        case .occurError(let error):
            newState.error = error
        }
        return newState
    }
}
