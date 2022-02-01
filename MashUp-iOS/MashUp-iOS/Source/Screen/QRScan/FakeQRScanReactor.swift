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
        self.initialState = State(captureSession: qrReader.captureSession, hasAttended: false)
        self.attencanceService = attendanceService
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didSetup:
            return self.qrReader.scanCode()
                .throttle(.seconds(5), scheduler: MainScheduler.instance)
                .flatMap { code -> Observable<Mutation> in
                    return .concat([
                        .just(.updateCode(code)),
                        self.attencanceService.attend(withCode: code).map { .updateAttendance($0)}
                    ])
                }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateCode(let code):
            newState.code = code
            
        case .updateAttendance(let attendance):
            newState.hasAttended = attendance
            if attendance {
                newState.alertMessage = "✅ 출석을 완료하셨습니다."
            } else {
                newState.alertMessage = "❌ 올바른 코드가 아닙니다."
            }
        }
        return newState
    }
    
    
    private let qrReader: QRReaderService
    private let attencanceService: AttendanceService
    
}
