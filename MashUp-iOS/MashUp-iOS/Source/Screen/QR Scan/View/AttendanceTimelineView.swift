//
//  AttendanceTimelineView.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/03/19.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import SnapKit
import Then
import UIKit

final class AttendanceTimelineView: BaseView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    func configure(with model: AttendanceTimelineViewModel) {
        self.phaseAttendanceView1.configure(with: model.phase1)
        self.phaseAttendanceView2.configure(with: model.phase2)
        self.totalPhaseAttendanceView.configure(with: model.total)
        self.configureStyle(model.phase1.style, for: self.lineView1)
        self.configureStyle(model.phase2.style, for: self.lineView2)
    }
    
    private func configureStyle(_ style: AttendanceStyle, for view: UIView) {
        switch style {
        case .attend: view.backgroundColor = .systemGreen
        case .lateness: view.backgroundColor = .systemOrange
        case .absence: view.backgroundColor = .systemRed
        case .upcoming: view.backgroundColor = .lightGray
        }
    }
    
    private let phaseAttendanceView1 = PhaseAttendanceView()
    private let phaseAttendanceView2 = PhaseAttendanceView()
    private let totalPhaseAttendanceView = PhaseAttendanceView()
    private let lineView1 = UIView()
    private let lineView2 = UIView()
}
// MARK: - Setup
extension AttendanceTimelineView {
    
    private func setupUI() {
        self.setupAttribute()
        self.setupLayout()
    }
    
    private func setupAttribute() {
        self.lineView1.do {
            $0.backgroundColor = .lightGray
        }
        self.lineView2.do {
            $0.backgroundColor = .lightGray
        }
    }
    
    private func setupLayout() {
        self.do {
            $0.addSubview(self.lineView1)
            $0.addSubview(self.lineView2)
            $0.addSubview(self.phaseAttendanceView1)
            $0.addSubview(self.phaseAttendanceView2)
            $0.addSubview(self.totalPhaseAttendanceView)
        }
        self.phaseAttendanceView1.snp.makeConstraints {
            $0.leading.bottom.top.equalToSuperview()
        }
        self.phaseAttendanceView2.snp.makeConstraints {
            $0.centerX.bottom.top.equalToSuperview()
        }
        self.totalPhaseAttendanceView.snp.makeConstraints {
            $0.trailing.bottom.top.equalToSuperview()
        }
        self.lineView1.snp.makeConstraints {
            $0.leading.equalTo(self.phaseAttendanceView1.snp.centerX)
            $0.trailing.equalTo(self.phaseAttendanceView2.snp.centerX)
            $0.top.equalToSuperview().inset(9)
            $0.height.equalTo(1)
        }
        self.lineView2.snp.makeConstraints {
            $0.top.equalToSuperview().inset(9)
            $0.leading.equalTo(self.phaseAttendanceView2.snp.centerX)
            $0.trailing.equalTo(self.totalPhaseAttendanceView.snp.centerX)
            $0.height.equalTo(1)
        }
    }
    
}

