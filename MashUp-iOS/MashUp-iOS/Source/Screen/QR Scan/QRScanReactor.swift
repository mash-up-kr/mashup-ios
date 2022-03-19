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
        case updateSeminar(Seminar)
    }
    
    struct State {
        let captureSession: AVCaptureSession
        var code: Code?
        var timer: TimerStyle?
        var seminarAttendancePhase: SeminarAttendancePhaseCardViewModel?
        @Pulse var toastMessage: String?
        
        fileprivate var isAdmin: Bool
        fileprivate var hasAttended: Bool
        fileprivate var seminar: Seminar?
    }
    
    let initialState: State
    
    init(
        qrReaderService: QRReaderService = QRReaderServiceImpl(),
        seminarRepository: SeminarRepository = FakeSeminarRepository(),
        attendanceService: AttendanceService = AttendanceServiceImpl(),
        timerService: TimerService = TimerServiceImpl()
    ) {
        self.qrReaderService = qrReaderService
        self.attencanceService = attendanceService
        self.seminarRepository = seminarRepository
        self.timerService = timerService
        
        self.initialState = State(
            captureSession: qrReaderService.captureSession,
            timer: TimerStyle(isAdmin: true, remainTime: nil),
            seminarAttendancePhase: nil,
            isAdmin: true,
            hasAttended: false
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didSetup:
            let readyToQRScan: Observable<Mutation> = self.qrReaderService.scanCodeWhileSessionIsOpen()
                .flatMap(self.updateCodeAndAttendance)
            let updateSeminar: Observable<Mutation> = self.seminarRepository.nearestSeminar()
                .map { .updateSeminar($0) }
            return .merge(readyToQRScan, updateSeminar)
            
        case .didTapTimerButton:
            let timeLimit: TimeInterval = 15 * minutes
            return self.timerService.start(timeLimit).map { .updateRemainTime($0) }
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
            let remainTimeText = self.formatTime(from: remainTime)
            newState.timer = TimerStyle(isAdmin: currentState.isAdmin, remainTime: remainTimeText)
            
        case .updateSeminar(let seminar):
            newState.seminar = seminar
            newState.seminarAttendancePhase = self.formatSeminar(from: seminar)
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
    
    private func formatSeminar(from seminar: Seminar) -> SeminarAttendancePhaseCardViewModel {
        return SeminarAttendancePhaseCardViewModel(
            title: seminar.title,
            dday: "오늘",
            date: self.formatDate(from: seminar.date),
            time: "15:00 ~ 16:30"
        )
    }
    
    private func formatTime(from seconds: TimeInterval) -> String? {
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
    
    private func formatDate(from date: Date) -> String {
        let dateFormatter = DateFormatter().then {
            $0.dateFormat = "M월 d일 (E)"
            $0.timeZone = .UTC
            $0.locale = .ko_KR
        }
        return dateFormatter.string(from: date)
    }
    
    private let qrReaderService: QRReaderService
    private let attencanceService: AttendanceService
    private let seminarRepository: SeminarRepository
    private let timerService: TimerService
    
}
