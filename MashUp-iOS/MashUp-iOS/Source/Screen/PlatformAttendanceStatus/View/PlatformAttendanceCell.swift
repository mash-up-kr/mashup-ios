//
//  PlatformAttendanceCell.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/05/27.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

final class PlatformAttendanceCell: BaseCollectionViewCell {
    private let platformImageView: UIImageView = UIImageView()
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
        platformImageView.image = model.platform.icon
        
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
        addSubview(platformImageView)
        addSubview(platformLabel)
        addSubview(attendanceStatusStackView)
        
        platformImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.top.equalToSuperview().offset(12)
            $0.width.height.equalTo(30)
        }
        
        platformLabel.snp.makeConstraints {
            $0.leading.equalTo(platformImageView.snp.trailing).offset(5)
            $0.centerY.equalTo(platformImageView)
        }
        
        attendanceStatusStackView.snp.makeConstraints {
            $0.leading.equalTo(platformImageView)
            $0.top.equalTo(platformImageView.snp.bottom).offset(12)
            $0.bottom.equalToSuperview().inset(16)
        }
    }
    
    private func setupAttribute() {
        attendanceStatusStackView.spacing = 19
        attendanceStatusStackView.axis = .horizontal
        layer.cornerRadius = 10
        backgroundColor = .white
    }
}
