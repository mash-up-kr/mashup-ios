//
//  SeminarAttendancePhaseCardView.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/03/19.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import SnapKit
import Then
import UIKit

struct PhaseAttendanceViewModel: Equatable {
    let phase: SeminarPhase
    let timeStamp: String?
    let style: AttendanceStyle
}

struct AttendanceTimelineViewModel: Equatable {
    let phase1: PhaseAttendanceViewModel
    let phase2: PhaseAttendanceViewModel
    var total: PhaseAttendanceViewModel
}

struct QRSeminarCardViewModel: Equatable {
    let title: String
    let dday: String
    let date: String
    let time: String
    let timeline: AttendanceTimelineViewModel?
}

final class QRSeminarCardView: BaseView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    func configure(with model: QRSeminarCardViewModel) {
        self.titleLabel.text = model.title
        self.ddayLabel.text = model.dday
        self.dateLabel.text = model.date
        self.timeLabel.text = model.time
        
        self.d.text = "\(model.timeline?.phase1.style.title ?? .empty)-\(model.timeline?.phase2.style.title ?? .empty)-\(model.timeline?.total.style.title ?? .empty)"
    }
    
    private let titleLabel = UILabel()
    private let ddayLabel = UILabel()
    private let timeLabel = UILabel()
    private let dateLabel = UILabel()
    private let d = UILabel()
}

// MARK: - Setup
extension QRSeminarCardView {
    
    private func setupUI() {
        self.setupAttribute()
        self.setupLayout()
    }
    
    private func setupAttribute() {
        self.do {
            $0.layer.cornerRadius = 24
            $0.backgroundColor = .systemGray4
        }
        self.titleLabel.do {
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 18, weight: .bold)
        }
        self.timeLabel.do {
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 12, weight: .regular)
        }
        self.ddayLabel.do {
            $0.textColor = .lightGray
            $0.font = .systemFont(ofSize: 14, weight: .regular)
        }
        self.dateLabel.do {
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 14, weight: .medium)
        }
    }
    
    private func setupLayout() {
        self.do {
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.timeLabel)
            $0.addSubview(self.ddayLabel)
            $0.addSubview(self.dateLabel)
            $0.addSubview(self.d)
        }
        self.titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
        }
        self.ddayLabel.snp.makeConstraints {
            $0.centerY.equalTo(self.titleLabel)
            $0.trailing.equalToSuperview().inset(16)
        }
        self.timeLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
        }
        self.dateLabel.snp.makeConstraints {
            $0.top.equalTo(self.timeLabel.snp.bottom).offset(12)
            $0.leading.equalTo(self.timeLabel)
        }
        self.d.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    }
    
}
