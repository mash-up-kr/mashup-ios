//
//  QRScanFormatter.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/03/19.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Then
import Foundation

protocol QRScanFormatter {
    func formatTime(from seconds: TimeInterval) -> String?
    func formatTimeline(from timeline: AttendanceTimeline) -> AttendanceTimelineViewModel
    func formatSeminarAttendance(from seminar: Seminar, timeline: AttendanceTimeline) -> QRSeminarCardViewModel
}

final class QRScanFormatterImpl: QRScanFormatter {
    
    func formatTime(from seconds: TimeInterval) -> String? {
        let remainTimeOrZero = self.dateComponentFormatter.string(from: seconds) ?? "00:00"
        let remainTimeText = (remainTimeOrZero) == "00:00" ? nil : remainTimeOrZero
        return remainTimeText
    }
    
    func formatSeminarAttendance(from seminar: Seminar, timeline: AttendanceTimeline) -> QRSeminarCardViewModel {
        let timeline = self.formatTimeline(from: timeline)
        return QRSeminarCardViewModel(
            title: seminar.title,
            dday: "오늘",
            date: self.formatDate(from: seminar.date),
            time: "15:00 ~ 16:30",
            timeline: timeline
        )
    }
    
    func formatTimeline(from timeline: AttendanceTimeline) -> AttendanceTimelineViewModel {
        return AttendanceTimelineViewModel(
            partialAttendance1: self.formatPartialAttendanceViewModel(from: timeline.partialAttendance1 ?? .unloaded(.phase1)),
            partialAttendance2: self.formatPartialAttendanceViewModel(from: timeline.partialAttendance2 ?? .unloaded(.phase2)),
            totalAttendance: self.formatPartialAttendanceViewModel(from: timeline.totalAttendance)
        )
    }
    
    private func formatPartialAttendanceViewModel(from attendance: PartialAttendance) -> PartialAttendanceViewModel {
        let phase = attendance.phase
        let timestamp = self.formatTimestamp(from: attendance.timestamp)
        let style = self.formatAttandanceStatus(from: attendance.status)
        return PartialAttendanceViewModel(
            phase: phase,
            timestamp: timestamp,
            style: style
        )
    }
    
    private func formatTimestamp(from timestamp: Date?) -> String? {
        guard let timestamp = timestamp else { return nil }
        let dateFormatter = DateFormatter().then {
            $0.timeZone = .UTC
            $0.dateFormat = "hh:mm:ss"
        }
        return dateFormatter.string(from: timestamp)
    }
    
    private func formatAttandanceStatus(from attandanceStatusOrNil: AttendanceStatus?) -> AttendanceStyle {
        switch attandanceStatusOrNil {
        case .attend: return .attend
        case .absence: return .absence
        case .lateness: return .lateness
        case .none: return .upcoming
        }
    }
    
    private func formatDate(from date: Date) -> String {
        return self.dateFormatter.string(from: date)
    }
    
    private let dateComponentFormatter = DateComponentsFormatter().then {
        $0.unitsStyle = .full
        $0.allowedUnits = [.minute, .second]
        $0.unitsStyle = .positional
        $0.zeroFormattingBehavior = .pad
        $0.maximumUnitCount = 2
    }
    private let dateFormatter = DateFormatter().then {
        $0.dateFormat = "M월 d일 (E)"
        $0.timeZone = .UTC
        $0.locale = .ko_KR
    }
    
}
