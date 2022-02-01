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

final class FakeQRScanReactor: Reactor {
    
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
        qrReader: QRReaderService = QRReaderServiceImpl(),
        attendanceService: AttendanceService = AttendanceServiceImpl()
    ) {
        self.qrReader = qrReader
        self.attencanceService = attendanceService
        self.initialState = State(captureSession: qrReader.captureSession, hasAttended: false)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didSetup:
            return self.qrReader.scanCode().flatMap(self.updateCodeAndAttendance)
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
        let updateCode = Observable.just(Mutation.updateCode(code))
        let updateAttendacne = self.attencanceService.attend(withCode: code).map { Mutation.updateAttendance($0) }
        return .concat(updateCode, updateAttendacne)
    }
    
    private func messageOf(attendance: Bool) -> String {
        return attendance ? "✅ 출석을 완료하셨습니다." : "❌ 올바른 코드가 아닙니다."
    }
    
    private let qrReader: QRReaderService
    private let attencanceService: AttendanceService
    
}
