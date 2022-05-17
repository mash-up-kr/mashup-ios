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
        self.partialAttendanceView1.configure(with: model.partialAttendance1)
        self.partialAttendanceView2.configure(with: model.partialAttendance2)
        self.totalAttendanceView.configure(with: model.totalAttendance)
        self.configureStyle(model.partialAttendance1.style, for: self.lineView1)
        self.configureStyle(model.partialAttendance2.style, for: self.lineView2)
    }
    
    private func configureStyle(_ style: AttendanceStyle, for view: UIView) {
        switch style {
        case .attend: view.backgroundColor = .systemGreen
        case .lateness: view.backgroundColor = .systemOrange
        case .absence: view.backgroundColor = .systemRed
        case .upcoming: view.backgroundColor = .lightGray
        }
    }
    
    private let partialAttendanceView1 = PartialAttendanceView()
    private let partialAttendanceView2 = PartialAttendanceView()
    private let totalAttendanceView = PartialAttendanceView()
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
            $0.addSubview(self.partialAttendanceView1)
            $0.addSubview(self.partialAttendanceView2)
            $0.addSubview(self.totalAttendanceView)
        }
        self.partialAttendanceView1.snp.makeConstraints {
            $0.leading.bottom.top.equalToSuperview()
        }
        self.partialAttendanceView2.snp.makeConstraints {
            $0.centerX.bottom.top.equalToSuperview()
        }
        self.totalAttendanceView.snp.makeConstraints {
            $0.trailing.bottom.top.equalToSuperview()
        }
        self.lineView1.snp.makeConstraints {
            $0.leading.equalTo(self.partialAttendanceView1.snp.centerX)
            $0.trailing.equalTo(self.partialAttendanceView2.snp.centerX)
            $0.top.equalToSuperview().inset(9)
            $0.height.equalTo(1)
        }
        self.lineView2.snp.makeConstraints {
            $0.top.equalToSuperview().inset(9)
            $0.leading.equalTo(self.partialAttendanceView2.snp.centerX)
            $0.trailing.equalTo(self.totalAttendanceView.snp.centerX)
            $0.height.equalTo(1)
        }
    }
    
}

