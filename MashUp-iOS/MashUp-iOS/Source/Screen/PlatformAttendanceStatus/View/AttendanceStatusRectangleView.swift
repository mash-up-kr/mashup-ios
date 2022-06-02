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
    }
    
    private func setupUI() {
        setupLayout()
        setupAttribute()
    }
    
    private func setupLayout() {
        addSubview(attendanceStatusTitleLabel)
        addSubview(attendanceStatusCountLabel)
        attendanceStatusTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.centerY.equalToSuperview()
        }
        
        attendanceStatusCountLabel.snp.makeConstraints {
            $0.leading.equalTo(attendanceStatusTitleLabel.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
    }
    
    private func setupAttribute() {
        layer.cornerRadius = 5
    }
}
