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
    private let containerStackView: UIStackView = UIStackView()
    
    private let platformContainerView: UIView = UIView()
    private let platformImageView: UIImageView = UIImageView()
    private let platformLabel: UILabel = UILabel()
    
    private let horizontalSeperatorView: UIView = UIView()
    private let verticalSeperatorView1: UIView = UIView()
    private let verticalSeperatorView2: UIView = UIView()
    
    // MARK: 출석진행중
    private let attendanceCountContainerView: UIView = UIView()
    /// 출석인원 타이틀
    private let attendanceCountTitleLabel: UILabel = UILabel()
    /// 출석인원/총인원 스텍뷰
    private let attendanceCountStackView: UIStackView = UIStackView()
    /// 출석인원
    private let attendanceCountLabel: UILabel = UILabel()
    /// 총인원
    private let attendanceTotalCountLabel: UILabel = UILabel()
    
    // MARK: 출석종료
    private let attendanceAllStatusContainerView: UIView = UIView()
    private let attendanceCountView = AttendanceStatusCountView()
    private let lateCountView = AttendanceStatusCountView()
    private let absentCountView = AttendanceStatusCountView()
    
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
        platformImageView.image = model.platform.icon
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
            
            attendanceCountView.configure(model: statusModel[0])
            lateCountView.configure(model: statusModel[1])
            absentCountView.configure(model: statusModel[2])
        }
        attendanceAllStatusContainerView.isHidden = isAttending
        attendanceCountContainerView.isHidden = !isAttending
    }
    
    private func updateAttendLabel(attend: Int, total: Int) {
        attendanceCountLabel.textColor = attend == 0 ? .gray500 : .green600
        attendanceCountLabel.text = "\(attend)"
        attendanceTotalCountLabel.text = "/\(total)"
    }
    
    private func setupUI() {
        setupLayout()
        setupAttribute()
    }
    
    private func setupLayout() {
        addSubview(containerStackView)
        containerStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.equalTo(144)
            $0.width.equalTo(134)
        }
        // 상단 플랫폼 나타내는 뷰레이아웃
        containerStackView.addArrangedSubview(platformContainerView)
        platformContainerView.addSubview(platformImageView)
        platformImageView.snp.makeConstraints {
            $0.top.centerX.equalToSuperview()
            $0.width.equalTo(60)
            $0.height.equalTo(48)
        }
        platformContainerView.addSubview(platformLabel)
        platformLabel.snp.makeConstraints {
            $0.top.equalTo(platformImageView.snp.bottom).offset(6)
            $0.centerX.equalToSuperview()
        }
        platformContainerView.addSubview(horizontalSeperatorView)
        horizontalSeperatorView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(1)
            $0.width.equalTo(134)
            $0.top.equalTo(platformLabel.snp.bottom).offset(16)
        }
        
        // 출석진행중 뷰레이아웃
        containerStackView.addArrangedSubview(attendanceCountContainerView)
        attendanceCountContainerView.snp.makeConstraints {
            $0.top.equalTo(horizontalSeperatorView.snp.bottom).offset(16)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(38)
            $0.width.equalTo(134)
        }
        attendanceCountContainerView.addSubview(attendanceCountTitleLabel)
        attendanceCountTitleLabel.snp.makeConstraints {
            $0.top.directionalHorizontalEdges.equalToSuperview()
            $0.height.equalTo(14)
        }
        
        attendanceCountContainerView.addSubview(attendanceCountStackView)
        attendanceCountStackView.snp.makeConstraints {
            $0.top.equalTo(attendanceCountTitleLabel.snp.bottom).offset(2)
            $0.centerX.bottom.equalToSuperview()
            $0.height.equalTo(22)
        }
        attendanceCountStackView.addArrangedSubview(attendanceCountLabel)
        attendanceCountStackView.addArrangedSubview(attendanceTotalCountLabel)
        
        // 출석완료 뷰레이아웃
        containerStackView.addArrangedSubview(attendanceAllStatusContainerView)
        attendanceAllStatusContainerView.addSubview(attendanceCountView)
        attendanceAllStatusContainerView.addSubview(verticalSeperatorView1)
        attendanceAllStatusContainerView.addSubview(lateCountView)
        attendanceAllStatusContainerView.addSubview(verticalSeperatorView2)
        attendanceAllStatusContainerView.addSubview(absentCountView)
        attendanceCountView.snp.makeConstraints {
            $0.directionalVerticalEdges.leading.equalToSuperview()
            $0.width.equalTo(44)
            $0.height.equalTo(38)
        }
        verticalSeperatorView1.snp.makeConstraints {
            $0.leading.equalTo(attendanceCountView.snp.trailing)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(1)
            $0.height.equalTo(20)
        }
        lateCountView.snp.makeConstraints {
            $0.leading.equalTo(verticalSeperatorView1.snp.trailing)
            $0.size.equalTo(attendanceCountView)
            $0.centerY.equalTo(attendanceCountView)
        }
        verticalSeperatorView2.snp.makeConstraints {
            $0.leading.equalTo(lateCountView.snp.trailing)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(1)
            $0.height.equalTo(20)
        }
        absentCountView.snp.makeConstraints {
            $0.leading.equalTo(verticalSeperatorView2.snp.trailing)
            $0.trailing.equalToSuperview()
            $0.size.equalTo(attendanceCountView)
            $0.centerY.equalTo(attendanceCountView)
        }
    }
    
    private func setupAttribute() {
        containerStackView.do {
            $0.axis = .vertical
            $0.spacing = 16
            $0.distribution = .equalSpacing
        }
        
        [horizontalSeperatorView, verticalSeperatorView1, verticalSeperatorView2].forEach {
            $0.backgroundColor = .gray100
        }
        platformLabel.textAlignment = .center
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
        platformLabel.font = .pretendardFont(weight: .bold, size: 16)
    }
    
    private func setAttendanceCountViewArea() {
        attendanceCountTitleLabel.textAlignment = .center
        attendanceCountTitleLabel.textColor = .gray500
        attendanceCountTitleLabel.font = .pretendardFont(weight: .regular, size: 12)
        attendanceCountLabel.textColor = .gray500
        attendanceCountLabel.font = .pretendardFont(weight: .semiBold, size: 18)
        attendanceTotalCountLabel.textColor = .gray700
        attendanceTotalCountLabel.font = .pretendardFont(weight: .semiBold, size: 18)
        
        attendanceCountStackView.distribution = .equalCentering
        attendanceCountStackView.spacing = 0
        attendanceCountTitleLabel.text = "출석/전체"
        attendanceCountLabel.text = "0"
        attendanceTotalCountLabel.text = "/0"
    }
}
