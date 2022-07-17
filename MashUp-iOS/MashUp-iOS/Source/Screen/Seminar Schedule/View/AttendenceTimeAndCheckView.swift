//
//  AttendenceTimeAndCheckView.swift
//  MashUp-iOS
//
//  Created by 이문정 on 2022/06/18.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import SnapKit
import Then
import UIKit
import MashUp_Core

final class AttendenceTimeAndCheckView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        setupUI()
    }
    private let checkImageView = UIImageView()
    private let seminarSectionLabel = UILabel()
    private let attendenceLabel = UILabel()
    private let timeLabel = UILabel()
}

extension AttendenceTimeAndCheckView {
    private func setupUI() {
        self.setupLayout()
        self.setupAttribute()
    }
    
    private func setupAttribute() {
        layoutIfNeeded()
        self.checkImageView.do {
            $0.backgroundColor = .green500
            $0.layer.cornerRadius = $0.bounds.width / 2
            $0.clipsToBounds = true
        }
        self.seminarSectionLabel.do {
            $0.text = "1부"
            $0.textColor = .gray600
            $0.font = .pretendardFont(weight: .regular, size: 12)
        }
        self.attendenceLabel.do {
            $0.text = "출석"
            $0.textColor = .gray600
            $0.font = .pretendardFont(weight: .semiBold, size: 16)
        }
        self.timeLabel.do {
            $0.text = "오후 3:25"
            $0.textColor = .gray500
            $0.font = .pretendardFont(weight: .regular, size: 14)
        }
    }
    
    private func setupLayout() {
        self.do {
            $0.addSubview(self.checkImageView)
            $0.addSubview(self.seminarSectionLabel)
            $0.addSubview(self.attendenceLabel)
            $0.addSubview(self.timeLabel)
        }
        
        self.checkImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(34)
        }
        
        self.seminarSectionLabel.snp.makeConstraints {
            $0.top.equalTo(self.checkImageView.snp.top)
            $0.leading.equalTo(self.checkImageView.snp.trailing).offset(12)
        }
        self.attendenceLabel.snp.makeConstraints {
            $0.top.equalTo(self.seminarSectionLabel.snp.bottom).inset(2)
            $0.leading.equalTo(self.seminarSectionLabel.snp.leading)
        }
        self.timeLabel.snp.makeConstraints {
            $0.top.equalTo(self.attendenceLabel.snp.top)
            $0.trailing.equalToSuperview()
        }
    }
}
