//
//  SeminarScheduleReactor.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import ReactorKit


final class SeminarScheduleReactor: Reactor {
    typealias Section = SeminarSection
    
    enum Action {
        case didSetup
        case didSelectSeminar(at: Int)
    }
    
    enum Mutation {
        case updateLoading(Bool)
        case updateLoadingNextPage(Bool)
        case updateSeminars([Seminar])
        case appendSeminars([Seminar])
        case move(to: SeminarSchduleStep)
    }
    
    struct State {
        var isLoading: Bool = false
        var isLoadingNextPage: Bool = false
        var sections: [Section] = []
        
        @Pulse var step: SeminarSchduleStep?
        fileprivate var seminars: [Seminar] = []
    }
    
    let initialState = State()
    
    init(
        seminarRepository: SeminarRepository,
        seminarSchedulerFormatter: SeminarSchedulerFormatter
    ) {
        self.seminarRepository = seminarRepository
        self.formatter = seminarSchedulerFormatter
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didSetup:
            let startLoading: Observable<Mutation> = .just(.updateLoading(true))
            let fetchSeminars: Observable<Mutation> = self.seminarRepository.fetchSeminars().map { .updateSeminars($0) }
            let endLoading: Observable<Mutation> = .just(.updateLoading(false))
            return .concat(startLoading, fetchSeminars, endLoading)
            
        case .didSelectSeminar(let index):
            guard let seminar = self.currentState.seminars[safe: index] else { return .empty() }
            let moveToSeminarDetail: Observable<Mutation> = .just(.move(to: .seminarDetail(seminarID: seminar.id)))
            return moveToSeminarDetail
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateLoading(let isLoading):
            newState.isLoading = isLoading
            
        case .updateLoadingNextPage(let isLoadingNextPage):
            newState.isLoadingNextPage = isLoadingNextPage
            
        case .updateSeminars(let seminars):
            newState.seminars = seminars
            newState.sections = self.formatter.formatSection(from: seminars, onLoadingPage: false)
            
        case .appendSeminars(let seminars):
            newState.seminars += seminars
            newState.sections = self.formatter.formatSection(from: newState.seminars, onLoadingPage: false)
            
        case .move(let step):
            newState.step = step
        }
        return newState
    }
    
    private let seminarRepository: SeminarRepository
    private let formatter: SeminarSchedulerFormatter
}
