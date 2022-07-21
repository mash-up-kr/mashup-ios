//
//  AttendanceStatusRectangleView.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/05/27.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_Core

final class AttendanceStatusCountView: BaseView {
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
        attendanceStatusTitleLabel.textColor = .gray500
        attendanceStatusCountLabel.text = "\(model.count)"
        attendanceStatusCountLabel.textColor = model.titleColor
    }
    
    private func setupUI() {
        setupLayout()
        setupAttribute()
    }
    
    private func setupLayout() {
        addSubview(attendanceStatusTitleLabel)
        addSubview(attendanceStatusCountLabel)
        
        attendanceStatusTitleLabel.snp.makeConstraints {
            $0.directionalHorizontalEdges.top.equalToSuperview()
            $0.height.equalTo(14)
        }
        
        attendanceStatusCountLabel.snp.makeConstraints {
            $0.top.equalTo(attendanceStatusTitleLabel.snp.bottom).offset(2)
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(22)
        }
    }
    
    private func setupAttribute() {
        attendanceStatusTitleLabel.textAlignment = .center
        attendanceStatusTitleLabel.font = .pretendardFont(weight: .regular, size: 12)
        attendanceStatusCountLabel.textAlignment = .center
        attendanceStatusCountLabel.font = .pretendardFont(weight: .semiBold, size: 18)
    }
}
