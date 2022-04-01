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
        case didSelectPlatform(at: Int)
    }
    
    enum Mutation {
        case updateLoading(Bool)
        case updateMembers([AttendanceMember])
        case updateSelectedPlatformIndex(Int)
        case occurError(Error)
    }
    
    struct State {
        var isLoading: Bool = false
        var selectedPlatformIndex: Int = 0
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
        case .didSelectPlatform(let index):
            let startLoading: Observable<Mutation> = .just(.updateLoading(true))
            let selectedPlatform: Observable<Mutation> = .just(.updateSelectedPlatformIndex(index))
            let platform = platform(index: index)
            let loadMember: Observable<Mutation> = attendanceService.attendanceMembers(platform: platform)
                .map { .updateMembers($0) }
            let endLoading: Observable<Mutation> = .just(.updateLoading(false))
            
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
        case .updateSelectedPlatformIndex(let index):
            newState.selectedPlatformIndex = index
        case .occurError(let error):
            newState.error = error
        }
        return newState
    }
}
