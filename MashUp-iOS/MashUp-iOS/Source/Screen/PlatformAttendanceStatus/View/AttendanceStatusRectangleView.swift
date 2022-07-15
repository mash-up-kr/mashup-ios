//
//  AttendanceStatusRectangleView.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/05/27.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_Core

final class AttendanceStatusRectangleView: BaseView {
    private let attendanceStatusImageView: UIImageView = UIImageView()
    private let attendanceStatusTitleLabel: UILabel = UILabel()
    private let attendanceStatusCountLabel: UILabel = UILabel()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func configure(model: AttendanceStatusRectangleViewModel) {
        attendanceStatusTitleLabel.text = model.title
        attendanceStatusTitleLabel.textColor = model.titleColor
        attendanceStatusCountLabel.text = "\(model.count)"
        attendanceStatusCountLabel.textColor = model.titleColor
        backgroundColor = model.backgroundColor
        attendanceStatusImageView.image = model.image
    }
    
    private func setupUI() {
        setupLayout()
        setupAttribute()
    }
    
    private func setupLayout() {
        addSubview(attendanceStatusImageView)
        addSubview(attendanceStatusTitleLabel)
        addSubview(attendanceStatusCountLabel)
        
        attendanceStatusImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(20)
        }
        
        attendanceStatusTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(attendanceStatusImageView.snp.trailing)
            $0.centerY.equalToSuperview()
        }
        
        attendanceStatusCountLabel.snp.makeConstraints {
            $0.leading.equalTo(attendanceStatusTitleLabel.snp.trailing).offset(2)
            $0.trailing.equalToSuperview().inset(12)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setupAttribute() {
        layer.cornerRadius = 8
        attendanceStatusTitleLabel.font = .pretendardFont(weight: .medium, size: 16)
        attendanceStatusCountLabel.font = .pretendardFont(weight: .semiBold, size: 16)
    }
}
