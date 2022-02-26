//
//  SeminarCardCell.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import SnapKit
import Then
import UIKit

final class SeminarCardCell: BaseCollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    func configure(with model: SeminarCardCellModel) {
        self.titleLabel.text = model.title
        self.summaryLabel.text = model.summary
        self.ddayLabel.text = model.dday
        self.dateLabel.text = model.date
        self.timeLabel.text = model.time
        self.attendanceBadge.text = model.attendance.title
        self.attendanceBadge.backgroundColor = model.attendance.color
    }
    
    private let cardShapeView = UIView()
    private let titleLabel = UILabel()
    private let summaryLabel = UILabel()
    private let ddayLabel = UILabel()
    private let timeLabel = UILabel()
    private let dateLabel = UILabel()
    private let attendanceBadge = PaddingLabel()
    
}
// MARK: - Setup
extension SeminarCardCell {
    
    private func setupUI() {
        self.setupAttribute()
        self.setupLayout()
    }
    
    private func setupAttribute() {
        self.cardShapeView.do {
            $0.layer.cornerRadius = 12
        }
        self.attendanceBadge.do {
            $0.textColor = .white
        }
    }
    
    private func setupLayout() {
        self.contentView.addSubview(self.cardShapeView)
        self.cardShapeView.do {
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.timeLabel)
            $0.addSubview(self.ddayLabel)
            $0.addSubview(self.summaryLabel)
            $0.addSubview(self.dateLabel)
            $0.addSubview(self.attendanceBadge)
        }
        self.cardShapeView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        self.titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(20)
        }
        self.ddayLabel.snp.makeConstraints {
            $0.centerY.equalTo(self.titleLabel)
            $0.trailing.equalToSuperview().inset(8)
        }
        self.timeLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
        }
        self.summaryLabel.snp.makeConstraints {
            $0.height.equalTo(36)
        }
        self.dateLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(20)
        }
        self.attendanceBadge.snp.makeConstraints {
            $0.top.equalTo(self.summaryLabel.snp.bottom)
            $0.trailing.bottom.equalToSuperview().inset(20)
        }
    }
    
}
