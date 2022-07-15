//
//  AttendanceDetailCell.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/06/09.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_Core

final class AttendanceDetailCell: BaseCollectionViewCell {
    private let nameLabel: UILabel = UILabel()
    private let firstHalfStatusView: AttendanceStatusCircleView = AttendanceStatusCircleView(phase: .phase1)
    private let secondHalfStatusView: AttendanceStatusCircleView = AttendanceStatusCircleView(phase: .phase2)
    private let finalStatusView: AttendanceStatusCircleView = AttendanceStatusCircleView(phase: .total)
    private let verticalLineView: UIView = UIView()
    private let horizontalLineView1: UIView = UIView()
    private let horizontalLineView2: UIView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        setupLayout()
        setupAttribute()
    }
    
    private func setupLayout() {
        addSubview(nameLabel)
        addSubview(verticalLineView)
        addSubview(firstHalfStatusView)
        addSubview(horizontalLineView1)
        addSubview(secondHalfStatusView)
        addSubview(horizontalLineView2)
        addSubview(finalStatusView)
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        verticalLineView.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(1)
            $0.height.equalTo(38)
        }
        firstHalfStatusView.snp.makeConstraints {
            $0.leading.equalTo(verticalLineView.snp.trailing).offset(22)
            $0.centerY.equalToSuperview()
        }
        horizontalLineView1.snp.makeConstraints {
            $0.leading.equalTo(firstHalfStatusView.snp.trailing)
            $0.trailing.equalTo(secondHalfStatusView.snp.leading)
            $0.top.equalTo(firstHalfStatusView).offset(9.5)
            $0.width.equalTo(35)
            $0.height.equalTo(1)
        }
        secondHalfStatusView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
        }
        horizontalLineView2.snp.makeConstraints {
            $0.leading.equalTo(secondHalfStatusView.snp.trailing)
            $0.trailing.equalTo(finalStatusView.snp.leading)
            $0.centerY.equalTo(horizontalLineView1)
            $0.width.equalTo(35)
            $0.height.equalTo(1)
        }
        finalStatusView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setupAttribute() {
        nameLabel.do {
            $0.font = .pretendardFont(weight: .bold, size: 16)
            $0.textColor = .gray800
            $0.textAlignment = .center
        }
        verticalLineView.backgroundColor = .gray200
        horizontalLineView1.backgroundColor = .gray200
        horizontalLineView2.backgroundColor = .gray200
        
        self.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 12
            $0.addShadow(x: 0, y: 2, color: .black, radius: 20, opacity: 0.1)
        }
    }
    
    func configure(model: AttendanceMember) {
        nameLabel.text = model.name
        let firstStatus = AttendanceStatusCircleViewModel(timestamp: model.firstSeminarAttendanceTimeStamp,
                                                          status: model.firstSeminarAttendance)
        let secondStatus = AttendanceStatusCircleViewModel(timestamp: model.secondSeminarAttendanceTimeStamp,
                                                          status: model.secondSeminarAttendance)
        let finalStatus = AttendanceStatusCircleViewModel(timestamp: model.secondSeminarAttendanceTimeStamp,
                                                          status: model.finalSeminarAttendance)
        firstHalfStatusView.configure(model: firstStatus)
        secondHalfStatusView.configure(model: secondStatus)
        finalStatusView.configure(model: finalStatus)
    }
}
