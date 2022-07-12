//
//  NowAttendenceView.swift
//  MashUp-iOS
//
//  Created by 이문정 on 2022/06/18.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import SnapKit
import Then
import UIKit
import MashUp_Core

class NowAttendenceView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        self.setupUI()
    }
    
    func configure(with model: SeminarCardCellModel) {
        
    }
    
    private let nameLabel = UILabel()
    private let nowAttendanceLabel = UILabel()
    private let firstAttendenceTimeAndCheckView: AttendenceTimeAndCheckView = AttendenceTimeAndCheckView(frame: .zero)
    private let secondAttendenceTimeAndCheckView: AttendenceTimeAndCheckView = AttendenceTimeAndCheckView(frame:.zero)
    private let finalAttendenceTimeAndCheckView: AttendenceTimeAndCheckView = AttendenceTimeAndCheckView(frame: .zero)
    private let firstlineView = UIView()
    private let secondlineView = UIView()

}

extension NowAttendenceView {
    private func setupUI() {
        self.setupAttribute()
        self.setupLayout()
    }
    
    private func setupAttribute() {
        
        self.nameLabel.do {
            $0.text = "홍길동"
            $0.textColor = .gray600
            $0.font = .pretendardFont(weight: .bold, size: 16)
        }
        
        self.nowAttendanceLabel.do {
            $0.text = "님의 현재 출석 현황이에요"
            $0.textColor = .gray700
            $0.font = .pretendardFont(weight: .medium, size: 16)
        }
        
        self.firstlineView.do {
            $0.backgroundColor = .gray200
        }
        
        self.secondlineView.do {
            $0.backgroundColor = .gray200
        }
    }
    private func setupLayout() {
        self.do {
            $0.addSubview(self.nameLabel)
            $0.addSubview(self.nowAttendanceLabel)
            $0.addSubview(self.firstAttendenceTimeAndCheckView)
            $0.addSubview(self.secondAttendenceTimeAndCheckView)
            $0.addSubview(self.finalAttendenceTimeAndCheckView)
            $0.addSubview(self.nowAttendanceLabel)
            $0.addSubview(self.firstlineView)
            $0.addSubview(self.secondlineView)
        }
        self.nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(42)
        }
        self.nowAttendanceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22)
            $0.leading.equalTo(self.nameLabel.snp.trailing)
            $0.trailing.equalToSuperview().inset(20)
        }
        self.firstAttendenceTimeAndCheckView.snp.makeConstraints {
            $0.height.equalTo(34)
            $0.top.equalTo(self.nameLabel.snp.bottom).offset(16)
            $0.leading.equalTo(self.nameLabel.snp.leading)
            $0.trailing.equalToSuperview().inset(20)
        }
        self.firstlineView.snp.makeConstraints{
            $0.width.equalTo(1)
            $0.height.equalTo(34)
            $0.top.equalTo(self.firstAttendenceTimeAndCheckView.snp.bottom)
            $0.leading.leading.equalTo(37)
        }
        self.secondAttendenceTimeAndCheckView.snp.makeConstraints {
            $0.height.equalTo(34)
            $0.top.equalTo(self.firstlineView.snp.bottom)
            $0.leading.equalTo(self.firstAttendenceTimeAndCheckView.snp.leading)
            $0.trailing.equalTo(self.firstAttendenceTimeAndCheckView.snp.trailing)
        }
        self.secondlineView.snp.makeConstraints{
            $0.width.equalTo(1)
            $0.height.equalTo(34)
            $0.top.equalTo(self.secondAttendenceTimeAndCheckView.snp.bottom)
            $0.leading.equalTo(37)
        }
        self.finalAttendenceTimeAndCheckView.snp.makeConstraints {
            $0.height.equalTo(34)
            $0.top.equalTo(self.secondlineView.snp.bottom)
            $0.leading.equalTo(self.secondAttendenceTimeAndCheckView.snp.leading)
            $0.trailing.equalTo(self.secondAttendenceTimeAndCheckView.snp.trailing)
            $0.bottom.equalToSuperview().inset(22)
        }
    }
}
    
