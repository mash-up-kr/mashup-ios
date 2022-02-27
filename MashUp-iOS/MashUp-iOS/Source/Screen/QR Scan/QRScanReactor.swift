//
//  FakeQRScanReactor.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/02.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import ReactorKit
import AVFoundation

final class QRScanReactor: Reactor {
    
    enum Action {
        case didSetup
    }
    
    enum Mutation {
        case updateCode(Code)
        case updateAttendance(Bool)
    }
    
    struct State {
        let captureSession: AVCaptureSession
        var code: Code?
        @Pulse var alertMessage: String?
        
        fileprivate var hasAttended: Bool
    }
    
    let initialState: State
    
    init(
        qrReaderService: QRReaderService = QRReaderServiceImpl(),
        attendanceService: AttendanceService = AttendanceServiceImpl()
    ) {
        self.qrReaderService = qrReaderService
        self.attencanceService = attendanceService
        self.initialState = State(captureSession: qrReaderService.captureSession, hasAttended: false)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didSetup:
            return self.qrReaderService.scanCodeWhileSessionIsOpen()
                .flatMap(self.updateCodeAndAttendance)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateCode(let code):
            newState.code = code
            
        case .updateAttendance(let attendance):
            newState.hasAttended = attendance
            newState.alertMessage = messageOf(attendance: attendance)
        }
        return newState
    }
    
    private func updateCodeAndAttendance(code: Code) -> Observable<Mutation> {
        guard self.currentState.hasAttended == false else { return .empty() }
        
        let updateCode = Observable.just(Mutation.updateCode(code))
        let updateAttendance = self.attencanceService.attend(withCode: code).map { Mutation.updateAttendance($0) }
        return .concat(updateCode, updateAttendance)
    }
    
    private func messageOf(attendance: Bool) -> String {
        return attendance ? "✅ 출석을 완료하셨습니다." : "❌ 올바른 코드가 아닙니다."
    }
    
    private let qrReaderService: QRReaderService
    private let attencanceService: AttendanceService
    
}
