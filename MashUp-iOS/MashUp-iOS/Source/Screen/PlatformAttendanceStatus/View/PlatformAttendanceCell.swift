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
    private let contentStackView: UIStackView = UIStackView()
    private let platformContainerView: UIView = UIView()
    private let platformLeftImageView: UIImageView = UIImageView()
    private let platformRightImageView: UIImageView = UIImageView()
    private let platformLabel: UILabel = UILabel()
    
    // MARK: 출석진행중
    private let attendanceCountContainerView: UIView = UIView()
    private let attendanceCountTitleLabel: UILabel = UILabel()
    private let attendanceCountStackView: UIStackView = UIStackView()
    private let attendanceCountLabel: UILabel = UILabel()
    private let attendanceTotalCountLabel: UILabel = UILabel()
    private let attendanceUnitLabel: UILabel = UILabel()
    
    // MARK: 출석종료
    private let attendanceStatusStackView: UIStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    func configure(model: PlatformAttendanceInformation, isAttending: Bool) {
        platformLabel.text = model.platform.title
        let icons = model.platform.icons
        platformLeftImageView.image = icons.0
        platformRightImageView.image = icons.1
        drawByAttend(isAttending,
                     numberOfAttend: model.numberOfAttend,
                     numberOfLateness: model.numberOfLateness,
                     numberOfAbsence: model.numberOfAbsence)
    }
    
    private func drawByAttend(_ isAttending: Bool,
                              numberOfAttend: Int,
                              numberOfLateness: Int,
                              numberOfAbsence: Int) {
        if isAttending {
            let total = numberOfAttend + numberOfAbsence + numberOfLateness
            updateAttendLabel(attend: numberOfAttend, total: total)
        } else {
            let statusModel = [AttendanceStatusRectangleViewModel(status: .attend, count: numberOfAttend),
                               AttendanceStatusRectangleViewModel(status: .lateness, count: numberOfLateness),
                               AttendanceStatusRectangleViewModel(status: .absence, count: numberOfAbsence)]
            statusModel.forEach {
                let view = AttendanceStatusRectangleView()
                view.configure(model: $0)
                attendanceStatusStackView.addArrangedSubview(view)
            }
        }
        attendanceStatusStackView.isHidden = isAttending
        attendanceCountContainerView.isHidden = !isAttending
    }
    
    private func updateAttendLabel(attend: Int, total: Int) {
        attendanceCountLabel.textColor = attend == 0 ? .gray300 : .green500
        attendanceCountLabel.text = "\(attend)"
        attendanceTotalCountLabel.text = "/\(total)"
    }
    
    private func setupUI() {
        setupLayout()
        setupAttribute()
    }
    
    private func setupLayout() {
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(platformContainerView)
        contentStackView.addArrangedSubview(attendanceStatusStackView)
        platformContainerView.addSubview(platformLeftImageView)
        platformContainerView.addSubview(platformRightImageView)
        platformContainerView.addSubview(platformLabel)
        addSubview(attendanceCountContainerView)
        attendanceCountContainerView.addSubview(attendanceCountTitleLabel)
        attendanceCountContainerView.addSubview(attendanceCountStackView)
        attendanceCountStackView.addArrangedSubview(attendanceCountLabel)
        attendanceCountStackView.addArrangedSubview(attendanceTotalCountLabel)
        attendanceCountStackView.addArrangedSubview(attendanceUnitLabel)
        
        contentStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().inset(20)
        }

        platformLeftImageView.snp.makeConstraints {
            $0.leading.top.equalToSuperview()
            $0.width.height.equalTo(20)
        }
        
        platformRightImageView.snp.makeConstraints {
            $0.leading.equalTo(platformLeftImageView.snp.trailing)
            $0.centerY.equalTo(platformLeftImageView)
            $0.width.height.equalTo(20)
        }
        
        platformLabel.snp.makeConstraints {
            $0.leading.equalTo(platformLeftImageView)
            $0.top.equalTo(platformLeftImageView.snp.bottom).offset(4)
            $0.bottom.equalToSuperview()
        }
        
        attendanceCountContainerView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        
        attendanceCountTitleLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview().offset(10)
        }
        
        attendanceCountStackView.snp.makeConstraints {
            $0.trailing.equalTo(attendanceCountTitleLabel)
            $0.top.equalTo(attendanceCountTitleLabel.snp.bottom).offset(4)
            $0.leading.bottom.equalToSuperview()
        }
        
        attendanceStatusStackView.snp.makeConstraints {
            $0.height.equalTo(32)
        }
    }
    
    private func setupAttribute() {
        contentStackView.do {
            $0.axis = .vertical
            $0.spacing = 14
        }
        attendanceStatusStackView.spacing = 4
        setPlatformViewArea()
        setAttendanceCountViewArea()
        self.do {
            $0.layer.cornerRadius = 10
            $0.backgroundColor = .white
            $0.addShadow(x: 0, y: 2, color: .black, radius: 20, opacity: 0.1)
        }
    }
    
    private func setPlatformViewArea() {
        platformLabel.textColor = .gray800
        platformLabel.font = .pretendardFont(weight: .bold, size: 20)
    }
    
    private func setAttendanceCountViewArea() {
        attendanceCountTitleLabel.textColor = .gray600
        attendanceCountTitleLabel.font = .pretendardFont(weight: .regular, size: 12)
        attendanceCountLabel.textColor = .gray300
        attendanceCountLabel.font = .pretendardFont(weight: .semiBold, size: 20)
        attendanceTotalCountLabel.textColor = .gray700
        attendanceTotalCountLabel.font = .pretendardFont(weight: .semiBold, size: 20)
        attendanceUnitLabel.textColor = .gray500
        attendanceUnitLabel.font = .pretendardFont(weight: .regular, size: 14)
        
        attendanceCountStackView.spacing = 2
        attendanceCountTitleLabel.text = "출석인원"
        attendanceUnitLabel.text = "명"
        attendanceCountLabel.text = "0"
        attendanceTotalCountLabel.text = "/0"
    }
}
