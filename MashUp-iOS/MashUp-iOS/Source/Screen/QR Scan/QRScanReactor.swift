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
        case updateAttendanceTimeline(AttendanceTimeline)
    }
    
    struct State {
        let captureSession: AVCaptureSession
        var code: Code?
        var timer: TimerStyle?
        var seminarCardViewModel: QRSeminarCardViewModel?
        @Pulse var toastMessage: String?
        
        fileprivate var isAdmin: Bool
        fileprivate var hasAttended: Bool
        fileprivate var seminar: Seminar?
        fileprivate var attendanceTimeline: AttendanceTimeline?
    }
    
    let initialState: State
    
    init(
        qrReaderService: QRReaderService,
        seminarRepository: SeminarRepository,
        attendanceService: AttendanceService,
        timerService: TimerService,
        attendanceTimelineRepository: AttendanceTimelineRepository,
        formatter: QRScanFormatter
    ) {
        self.qrReaderService = qrReaderService
        self.attencanceService = attendanceService
        self.seminarRepository = seminarRepository
        self.timerService = timerService
        self.attendanceTimelineRepository = attendanceTimelineRepository
        self.formatter = formatter
        
        self.initialState = State(
            captureSession: qrReaderService.captureSession,
            timer: TimerStyle(isAdmin: true, remainTime: nil),
            seminarCardViewModel: nil,
            isAdmin: true,
            hasAttended: false
        )
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .didSetup:
            let readyToQRScan: Observable<Mutation> = self.qrReaderService.scanCodeWhileSessionIsOpen()
                .flatMap(self.updateCodeAndAttendance)
            
            let seminar = self.seminarRepository.nearestSeminar().share()
            let updateSeminar: Observable<Mutation> = seminar.map { .updateSeminar($0) }
            
            #warning("dummy 프로토타이핑")
            let userID = Observable.just("fake.user.id")
            let seminarID = seminar.map { $0.id }
            
            let updateAttendanceTimeline: Observable<Mutation> = Observable.combineLatest(userID, seminarID)
                .flatMap { self.attendanceTimelineRepository.attendanceTimeline(ofUserID: $0, seminarID: $1) }
                .map { .updateAttendanceTimeline($0) }
            
            return .concat(
                readyToQRScan,
                updateSeminar,
                updateAttendanceTimeline
            )
            
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
            let remainTimeText = self.formatter.formatTime(from: remainTime)
            newState.timer = TimerStyle(isAdmin: currentState.isAdmin, remainTime: remainTimeText)
            
        case .updateSeminar(let seminar):
            newState.seminar = seminar
            newState.seminarCardViewModel = self.formatter.formatSeminarCard(from: seminar, timeline: .unloaded)
            
        case .updateAttendanceTimeline(let attendanceTimeline):
            guard let seminar = currentState.seminar else { return newState }
            newState.attendanceTimeline = attendanceTimeline
            newState.seminarCardViewModel = self.formatter.formatSeminarCard(from: seminar, timeline: attendanceTimeline)
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
    private let attendanceTimelineRepository: AttendanceTimelineRepository
    private let seminarRepository: SeminarRepository
    private let formatter: QRScanFormatter
    private let timerService: TimerService
    
}
