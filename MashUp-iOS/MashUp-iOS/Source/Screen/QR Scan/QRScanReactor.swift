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
import MashUp_Core

final class QRScanReactor: Reactor {
    
    enum Action {
        case didSetup
        case didTapClose
    }
    
    enum Mutation {
        case updateCode(Code)
        case updateAttendance(Bool)
        case updateClose
    }
    
    struct State {
        let captureSession: AVCaptureSession
        var code: Code?
        
        @Pulse var toastMessage: String?
        @Pulse var shouldClose: Void?
        
        fileprivate var hasAttended: Bool
    }
    
    let initialState: State
    
    init(
        qrReaderService: QRReaderService,
        attendanceService: AttendanceService,
        formatter: QRScanFormatter
    ) {
        self.qrReaderService = qrReaderService
        self.attencanceService = attendanceService
        self.formatter = formatter
        
        self.initialState = State(
            captureSession: qrReaderService.captureSession,
            hasAttended: false
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didSetup:
            let readyToQRScan: Observable<Mutation> = self.qrReaderService.scanCodeWhileSessionIsOpen()
                .flatMap(self.updateCodeAndAttendance)
            return readyToQRScan
            
        case .didTapClose:
            return .just(.updateClose)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateCode(let code):
            newState.code = code
            
        case .updateAttendance(let attendance):
            newState.hasAttended = attendance
            if attendance == false {
                newState.toastMessage = "올바르지 않은 QR 코드입니다"
            }
            
        case .updateClose:
            newState.shouldClose = Void()
        }
        return newState
    }
    
    private func updateCodeAndAttendance(code: Code) -> Observable<Mutation> {
        guard self.currentState.hasAttended == false else { return .empty() }
        
        let updateCode = Observable.just(Mutation.updateCode(code))
        let updateAttendance = self.attencanceService.attend(withCode: code).map { Mutation.updateAttendance($0) }
        return .concat(updateCode, updateAttendance)
    }
    
    private let qrReaderService: QRReaderService
    private let attencanceService: AttendanceService
    private let formatter: QRScanFormatter
    
}
