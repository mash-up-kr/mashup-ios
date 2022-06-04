//
//  PlatformAttendanceCell.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/05/27.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_Core
import MashUp_PlatformTeam
import MashUp_UIKit

final class PlatformAttendanceCell: BaseCollectionViewCell {
    private let platformLeftImageView: UIImageView = UIImageView()
    private let platformRightImageView: UIImageView = UIImageView()
    private let platformLabel: UILabel = UILabel()
    private let attendanceStatusStackView: UIStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func configure(model: PlatformAttendance) {
        platformLabel.text = model.platform.title
        let icons = model.platform.icons
        platformLeftImageView.image = icons.0
        platformRightImageView.image = icons.1
        
        let statusModel = [AttendanceStatusRectangleViewModel(status: .attend, count: model.numberOfAttend),
                     AttendanceStatusRectangleViewModel(status: .lateness, count: model.numberOfLateness),
                     AttendanceStatusRectangleViewModel(status: .absence, count: model.numberOfAbsence)]
        statusModel.forEach {
            let view = AttendanceStatusRectangleView()
            view.configure(model: $0)
            attendanceStatusStackView.addArrangedSubview(view)
        }
    }
    
    private func setupUI() {
        setupLayout()
        setupAttribute()
    }
    
    private func setupLayout() {
        addSubview(platformLeftImageView)
        addSubview(platformRightImageView)
        addSubview(platformLabel)
        addSubview(attendanceStatusStackView)
        
        platformLeftImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(22)
            $0.width.height.equalTo(22)
        }
        
        platformRightImageView.snp.makeConstraints {
            $0.leading.equalTo(platformLeftImageView.snp.trailing)
            $0.centerY.equalTo(platformLeftImageView)
            $0.width.height.equalTo(22)
        }
        
        platformLabel.snp.makeConstraints {
            $0.leading.equalTo(platformLeftImageView)
            $0.top.equalTo(platformLeftImageView.snp.bottom).offset(4)
        }
        
        attendanceStatusStackView.snp.makeConstraints {
            $0.leading.equalTo(platformLabel)
            $0.top.equalTo(platformLabel.snp.bottom).offset(14)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
    
    private func setupAttribute() {
        attendanceStatusStackView.spacing = 19
        attendanceStatusStackView.axis = .horizontal
        layer.cornerRadius = 10
        backgroundColor = .white
        platformLabel.font = .pretendardFont(weight: .bold, size: 20)
        platformLabel.textColor = .gray800
    }
}
