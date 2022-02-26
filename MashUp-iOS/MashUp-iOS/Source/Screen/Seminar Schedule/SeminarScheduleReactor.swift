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
        case move(SeminarSchduleStep)
    }
    
    struct State {
        var isLoading: Bool = false
        var isLoadingNextPage: Bool = false
        var sections: [Section] = []
        
        @Pulse var step: SeminarSchduleStep?
        fileprivate var seminars: [Seminar] = []
    }
    
    let initialState = State()
    
    init(seminarRepository: SeminarRepository) {
        self.seminarRepository = seminarRepository
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didSetup:
            let startLoading: Observable<Mutation> = .just(.updateLoading(true))
            let fetchSeminar: Observable<Mutation> = self.seminarRepository.fetchSeminars().map { .updateSeminars($0) }
            let endLoading: Observable<Mutation> = .just(.updateLoading(false))
            return .concat(startLoading, fetchSeminar, endLoading)
            
        case .didSelectSeminar(let index):
            guard let seminar = self.currentState.seminars[safe: index] else { return .empty() }
            return .just(.move(.seminarDetail(seminarID: seminar.id)))
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
            newState.sections = self.createSections(from: newState)
            
        case .appendSeminars(let seminars):
            newState.seminars += seminars
            newState.sections = self.createSections(from: newState)
            
        case .move(let step):
            newState.step = step
        }
        return newState
    }
    
    private let seminarRepository: SeminarRepository
}

extension SeminarScheduleReactor {
    
    private func createSections(from state: State) -> [Section] {
        let upcomingItems = state.seminars.map { self.createSeminarItem(from: $0, meta: .upcoming) }
        let totalItems = state.seminars.map { self.createSeminarItem(from: $0, meta: .total) }
        return [
            Section(type: .upcoming, items: upcomingItems),
            Section(type: .total, items: totalItems)
        ]
    }
    
    private func createSeminarItem(
        from seminar: Seminar,
        meta: SeminarSectionMeta
    ) -> Section.Item {
        let dateFormatter = DateFormatter().then {
            $0.dateFormat = "M월 d일 (E)"
            $0.timeZone = .UTC
            $0.locale = .ko_KR
        }
        let cellModel = SeminarCardCellModel(title: seminar.title,
                                             summary: seminar.summary,
                                             dday: ["오늘", "D-1", "D-2"].randomElement()!,
                                             date: dateFormatter.string(from: seminar.date),
                                             time: "오후 3시 30분 - 오후 4시 30분",
                                             attendance: .allCases.randomElement()!)
        switch meta {
        case .upcoming: return .upcoming(cellModel)
        case .total: return .total(cellModel)
        }
    }
    
}
