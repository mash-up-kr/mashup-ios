//
//  MembershipWithdrawalReactor.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/07/07.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import ReactorKit

final class MembershipWithdrawalReactor: Reactor {
    enum Action {
        case didEditConfirmTextField(String)
        case didTapWithdrawalButton
    }
    
    enum Mutation {
        case updateConfirmText(String)
        case updateValidate(Bool)
        case withdrawal(Bool)
        case occurError(Error)
    }
    
    struct State {
        var confirmText: String?
        var isValidated: Bool?
        @Pulse var isWithdrawnOfMembership: Bool?
        @Pulse var error: Error?
    }
    
    var initialState: State = State()
    
    private let service: MembershipWithdrawalService
    
    init(service: MembershipWithdrawalService) {
        self.service = service
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didEditConfirmTextField(let text):
            let validateObservable = checkValidate(text: text)
            let textObservable: Observable<Mutation> = .just(.updateConfirmText(text))
            return .concat(textObservable, validateObservable)
        case .didTapWithdrawalButton:
            return service.withdrawal()
                .map { Mutation.withdrawal($0) }
                .catch {
                    return .concat(.just(.occurError($0)), .just(.withdrawal(false)))
                }
        }
    }
    
    private func checkValidate(text: String) -> Observable<Mutation> {
        let validateString = "탈퇴할게요"
        return .just(.updateValidate(text == validateString))
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        
        switch mutation {
        case .updateConfirmText(let text):
            state.confirmText = text
        case .updateValidate(let isValidated):
            state.isValidated = isValidated
        case .withdrawal(let isSuccessful):
            state.isWithdrawnOfMembership = isSuccessful
        case .occurError(let error):
            state.error = error
        }
        
        return state
    }
}
