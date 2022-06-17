//
//  SeminarCardCell.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import SnapKit
import Then
import UIKit
import MashUp_Core

final class SeminarCardCell: BaseCollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    func configure(with model: SeminarCardCellModel) {
        self.titleLabel.text = model.title
        self.summaryLabel.text = model.summary
        self.timeLabel.text = model.time
        self.attendanceBadge.text = model.attendance.title
        self.attendanceBadge.backgroundColor = model.attendance.color
    }
    private let cardShapeView = UIView()
    private let myNowAttendence = UIView()
    private let titleLabel = UILabel()
    private let summaryLabel = UILabel()
    private let ddayLabel = UILabel()
    private let timeLabel = UILabel()
    private let calanderImageView = UIImageView()
    private let attendanceButton = UIView()
    private let attendanceBadge = PaddingLabel()
    
}
// MARK: - Setup
extension SeminarCardCell {
    
    private func setupUI() {
        self.setupAttribute()
        self.setupLayout()
    }
    
    private func setupAttribute() {
        self.cardShapeView.do {
            $0.layer.cornerRadius = 24
            $0.backgroundColor = .white
        }
        self.myNowAttendence.do{
            $0.layer.cornerRadius = 16
            $0.backgroundColor = .gray50
        }
        self.titleLabel.do {
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 24, weight: .bold)
        }
        self.timeLabel.do {
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 12, weight: .medium)
        }
        self.summaryLabel.do {
            $0.textColor = .darkGray
            $0.font = .systemFont(ofSize: 12, weight: .semibold)
        }
        self.attendanceButton.do {
            $0.backgroundColor = .gray50
        }
        self.calanderImageView.do {
            $0.backgroundColor = .red
        }
        self.attendanceBadge.do {
            $0.textColor = .white
            $0.font = .systemFont(ofSize: 14, weight: .regular)
            $0.layer.cornerRadius = 13
            $0.clipsToBounds = true
        }
    }
    
    private func setupLayout() {
        self.contentView.addSubview(self.cardShapeView)
        self.cardShapeView.do {
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.timeLabel)
            $0.addSubview(self.summaryLabel)
            $0.addSubview(self.attendanceButton)
            $0.addSubview(self.calanderImageView)
            $0.addSubview(self.attendanceBadge)
            $0.addSubview(self.myNowAttendence)
        }
       
        self.cardShapeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.attendanceBadge.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(24)
        }
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.attendanceBadge.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(20)
        }
        self.calanderImageView.snp.makeConstraints {
            $0.width.equalTo(16)
            $0.height.equalTo(13)
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(20)
        }
        self.timeLabel.snp.makeConstraints {
            $0.top.equalTo(self.calanderImageView.snp.top)
            $0.leading.equalTo(calanderImageView.snp.trailing).offset(6)
        }
        self.myNowAttendence.snp.makeConstraints {
            $0.width.equalTo(254)
            $0.height.equalTo(300)// 임시임
            $0.top.equalTo(self.timeLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        self.attendanceButton.snp.makeConstraints {
            $0.width.equalTo(254)
            $0.height.equalTo(28)
            $0.top.equalTo(self.myNowAttendence.snp.bottom).offset(18)
            $0.bottom.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
}
