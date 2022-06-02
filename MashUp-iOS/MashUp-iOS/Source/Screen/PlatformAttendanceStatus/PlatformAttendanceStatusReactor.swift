//
//  PlatformAttendanceStatusReactor.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/05/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import ReactorKit
import MashUp_PlatformTeam

final class PlatformAttendanceStatusReactor: Reactor {
    enum Action {
        case didSetup
        case didTapPlatform(PlatformTeam)
    }
    
    enum Mutation {
        case updatePlatformsAttendance([PlatformAttendance])
        case updateSelectedPlatform(PlatformTeam)
    }
    
    struct State {
        var platformsAttendance: [PlatformAttendance] = []
        var selectedPlatform: PlatformTeam?
    }
    
    let initialState: State
    private let platformService: any PlatformService
    
    init(platformService: PlatformService) {
        initialState = State()
        self.platformService = platformService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didSetup:
            return requestPlatformsAttendance()
        case .didTapPlatform(let platform):
            return .just(.updateSelectedPlatform(platform))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
        case .updatePlatformsAttendance(let platformsAttendance):
            state.platformsAttendance = platformsAttendance
        case .updateSelectedPlatform(let platform):
            state.selectedPlatform = platform
        }
        return state
    }
    
    private func requestPlatformsAttendance() -> Observable<Mutation> {
        return platformService.attendanceStatus()
            .flatMap { status -> Observable<Mutation> in
                    return .just(.updatePlatformsAttendance(status))
            }
    }
}
