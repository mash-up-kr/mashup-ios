//
//  AttendanceStatusCircleView.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/06/09.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_Core

final class AttendanceStatusCircleView: BaseView {
    private let outerView: UIView = UIView()
    private let innerView: UIView = UIView()
    private let innerImageView: UIImageView = UIImageView()
    private let statusLabel: UILabel = UILabel()
    private let timeLabel: UILabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupLayout()
        setupAttribute()
    }
    
    private func setupLayout() {
        addSubview(outerView)
        outerView.addSubview(innerView)
        outerView.addSubview(innerImageView)
        addSubview(statusLabel)
        addSubview(timeLabel)
        
        self.snp.makeConstraints {
            $0.width.equalTo(40)
        }
        outerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(20)
        }
        innerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(8)
        }
        innerImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(16)
        }
        statusLabel.snp.makeConstraints {
            $0.top.equalTo(outerView.snp.bottom).offset(4)
            $0.centerX.equalToSuperview()
        }
        timeLabel.snp.makeConstraints {
            $0.top.equalTo(statusLabel.snp.bottom)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setupAttribute() {
        layoutIfNeeded()
        outerView.do {
            $0.layer.cornerRadius = $0.bounds.width / 2
            $0.backgroundColor = .gray200
        }
        innerView.do {
            $0.layer.cornerRadius = $0.bounds.width / 2
            $0.backgroundColor = .white
        }
        innerImageView.image = .add.withTintColor(.white)
        statusLabel.do {
            $0.font = .pretendardFont(weight: .medium, size: 13)
            $0.textColor = .gray600
        }
        timeLabel.do {
            $0.font = .pretendardFont(weight: .regular, size: 12)
            $0.textColor = .gray500
            $0.text = "-"
        }
    }
    
    func configure(model: AttendanceStatusCircleViewModel) {
        outerView.backgroundColor = model.status?.color ?? .gray200
        statusLabel.text = model.status?.title ?? model.seminarPhase.rawValue
        timeLabel.text = model.timestamp ?? "-"
        innerImageView.isHidden = model.seminarPhase != .total
        innerView.isHidden = model.seminarPhase == .total
    }
}
