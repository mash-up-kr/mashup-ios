//
//  PartialAttendanceView.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/03/19.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import SnapKit
import Then
import UIKit
import MashUp_Core

final class PartialAttendanceView: BaseView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.circularizeStatusView()
    }
    
    func configure(with model: PartialAttendanceViewModel) {
        switch model.style {
        case .attend:
            self.statusView.backgroundColor = .systemGreen
        case .lateness:
            self.statusView.backgroundColor = .systemOrange
        case .absence:
            self.statusView.backgroundColor = .systemRed
        case .upcoming:
            self.statusView.backgroundColor = .lightGray
        }
        
        let phase = model.phase.rawValue
        if let timestamp = model.timestamp {
            self.describeLabel.text = "\(phase) | \(timestamp)"
        } else if model.phase == .total {
            self.describeLabel.text = model.style.title
        } else {
            self.describeLabel.text = phase
        }
    }
    
    private let statusView = UIView()
    private let describeLabel = UILabel()
}
// MARK: - Setup
extension PartialAttendanceView {
    
    private func setupUI() {
        self.setupAttribute()
        self.setupLayout()
    }
    
    private func setupAttribute() {
        self.do {
            $0.backgroundColor = .clear
        }
        self.describeLabel.do {
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 10, weight: .regular)
        }
    }
    
    private func setupLayout() {
        self.do {
            $0.addSubview(self.describeLabel)
            $0.addSubview(self.statusView)
        }
        self.statusView.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.width.height.equalTo(18)
        }
        self.describeLabel.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    private func circularizeStatusView() {
        self.statusView.do {
            $0.layer.cornerRadius = self.statusView.bounds.width / 2
        }
    }
    
}

