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
        case didTapTimerButton
    }
    
    enum Mutation {
        case updateCode(Code)
        case updateAttendance(Bool)
        case updateRemainTime(TimeInterval)
    }
    
    struct State {
        let captureSession: AVCaptureSession
        var code: Code?
        var timer: TimerStyle?
        var seminarAttendancePhase: SeminarAttendancePhaseCardViewModel?
        @Pulse var toastMessage: String?
        
        fileprivate var isAdmin: Bool
        fileprivate var hasAttended: Bool
    }
    
    let initialState: State
    
    init(
        qrReaderService: QRReaderService = QRReaderServiceImpl(),
        seminarRepository: SeminarRepository = SeminarRepositoryImpl(),
        attendanceService: AttendanceService = AttendanceServiceImpl()
    ) {
        self.qrReaderService = qrReaderService
        self.attencanceService = attendanceService
        
        let cardViewModel = SeminarAttendancePhaseCardViewModel(
            title: "3차 정기 매쉬업 세미나",
            dday: "오늘",
            date: "2월 21일(월)",
            time: "15:00 ~ 16:30"
        )
        self.initialState = State(
            captureSession: qrReaderService.captureSession,
            timer: TimerStyle(isAdmin: true, remainTime: nil),
            seminarAttendancePhase: cardViewModel,
            isAdmin: true,
            hasAttended: false
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didSetup:
            let readyToQRScan: Observable<Mutation> = self.qrReaderService.scanCodeWhileSessionIsOpen()
                .flatMap(self.updateCodeAndAttendance)
            return readyToQRScan
            
        case .didTapTimerButton:
            let timeLimit: TimeInterval = 15 * seconds
            return self.remainTime(timeLimit).map { .updateRemainTime($0) }
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .updateCode(let code):
            newState.code = code
            
        case .updateAttendance(let attendance):
            newState.hasAttended = attendance
            newState.toastMessage = self.messageOf(attendance: attendance)
            
        case .updateRemainTime(let remainTime):
            let remainTimeText = self.formatTime(remainTime)
            newState.timer = TimerStyle(isAdmin: currentState.isAdmin, remainTime: remainTimeText)
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
    
    private func remainTime(_ timeLimit: TimeInterval) -> Observable<TimeInterval> {
        return Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
            .map { TimeInterval($0) }
            .map { timeLimit - $0 }
            .take(while: { $0 >= 0 })
    }
    
    private func formatTime(_ seconds: TimeInterval) -> String? {
        let formatter = DateComponentsFormatter().then {
            $0.unitsStyle = .full
            $0.allowedUnits = [.minute, .second]
            $0.unitsStyle = .positional
            $0.zeroFormattingBehavior = .pad
            $0.maximumUnitCount = 2
        }
        let remainTimeOrZero = formatter.string(from: seconds) ?? "00:00"
        let remainTimeText = (remainTimeOrZero) == "00:00" ? nil : remainTimeOrZero
        return remainTimeText
    }
    
    private let qrReaderService: QRReaderService
    private let attencanceService: AttendanceService
    
}
