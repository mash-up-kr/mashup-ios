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
    typealias Section = SeminarScheduleSection
    
    enum Action {
        case didSetup
        case didTapQRButton
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
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didSetup:
            return .empty()
            
        case .didTapQRButton:
            return .just(.move(.qrScan))
            
        case .didSelectSeminar(let index):
            guard let seminar = self.currentState.seminars[safe: index] else { return .empty() }
            return .just(.move(.seminarDetail(id: seminar.id)))
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
    
    private func createSections(from state: State) -> [Section] {
        return []
    }
}
