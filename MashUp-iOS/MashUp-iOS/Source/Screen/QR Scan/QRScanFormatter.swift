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
    func formatSeminarCard(from seminar: Seminar, timeline: AttendanceTimeline) -> QRSeminarCardViewModel
}

final class QRScanFormatterImpl: QRScanFormatter {
    
    func formatTime(from seconds: TimeInterval) -> String? {
        guard seconds.isLess(than: 0) == false else { return nil }
        guard let remainTimeText = self.dateComponentFormatter.string(from: seconds) else { return nil }
        guard remainTimeText != "00:00" else { return nil }
        return remainTimeText
    }
    
    func formatTimeline(from timeline: AttendanceTimeline) -> AttendanceTimelineViewModel {
        let partialAttendanceViewModel1 = self.formatPartialAttendanceViewModel(from: timeline.partialAttendance1 ?? .unloaded(.phase1))
        let partialAttendanceViewModel2 = self.formatPartialAttendanceViewModel(from: timeline.partialAttendance2 ?? .unloaded(.phase2))
        let totalAttendanceViewModel = self.formatPartialAttendanceViewModel(from: timeline.totalAttendance)
        return AttendanceTimelineViewModel(
            partialAttendance1: partialAttendanceViewModel1,
            partialAttendance2: partialAttendanceViewModel2,
            totalAttendance: totalAttendanceViewModel
        )
    }
    
    func formatSeminarCard(from seminar: Seminar, timeline: AttendanceTimeline) -> QRSeminarCardViewModel {
        let timeline = self.formatTimeline(from: timeline)
        return QRSeminarCardViewModel(
            title: seminar.title,
            dday: "오늘",
            date: self.formatDate(from: seminar.date),
            time: "15:00 ~ 16:30",
            timeline: timeline
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
        return self.timeStampFormatter.string(from: timestamp)
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
    
    private let dateFormatter = DateFormatter().then {
        $0.dateFormat = "M월 d일 (E)"
        $0.timeZone = .UTC
        $0.locale = .ko_KR
    }
    private let timeStampFormatter = DateFormatter().then {
        $0.timeZone = .UTC
        $0.dateFormat = "hh:mm:ss"
    }
    private let dateComponentFormatter = DateComponentsFormatter().then {
        $0.unitsStyle = .full
        $0.allowedUnits = [.minute, .second]
        $0.unitsStyle = .positional
        $0.zeroFormattingBehavior = .pad
        $0.maximumUnitCount = 2
    }
    
}
