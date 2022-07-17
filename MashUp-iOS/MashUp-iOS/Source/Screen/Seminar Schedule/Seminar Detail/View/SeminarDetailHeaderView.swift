//
//  SeminarDetailHeaderView.swift
//  MashUp-iOS
//
//  Created by 이문정 on 2022/07/02.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import SnapKit
import Then
import UIKit
import MashUp_Core

protocol SeminarDetailHeaderViewDelegate: AnyObject {
    func SeminarDetailHeaderView(_ headerView: SeminarDetailHeaderView)
}

final class SeminarDetailHeaderView: UICollectionReusableView, Reusable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    func configure(sectionType: SeminarDetailSectionType) {
        self.seminarSectionLabel.text = sectionType.header
    }
    
    private let seminarSectionLabel = UILabel()
    private let sectionTimePaddingView = UIView()
    private let sectionTimeImageView = UILabel()
    private let sectionTimeLabel = UILabel()

}
// MARK: - Setup
extension SeminarDetailHeaderView {
    
    private func setupUI() {
        self.setupAttribute()
        self.setupLayout()
    }
    
    private func setupAttribute() {
        self.seminarSectionLabel.do {
            $0.text = "n부"
            $0.textColor = .gray800
            $0.font = .pretendardFont(weight: .bold, size: 20)
        }
        self.sectionTimePaddingView.do {
            $0.backgroundColor = .gray600
            $0.layer.cornerRadius = 13
        }
        self.sectionTimeImageView.do {
            $0.backgroundColor = .black
        }
        self.sectionTimeLabel.do {
            $0.text = "AM 11:00 - PM 2:00"
            $0.textColor = .purple
            $0.font = .pretendardFont(weight: .medium, size: 13)
        }
    }
    
    private func setupLayout() {
        self.addSubview(self.seminarSectionLabel)
        self.addSubview(self.sectionTimePaddingView)
        self.sectionTimePaddingView.addSubview(self.sectionTimeImageView)
        self.sectionTimePaddingView.addSubview(self.sectionTimeLabel)
        self.seminarSectionLabel.snp.makeConstraints{
            $0.top.equalToSuperview().inset(36)
            $0.bottom.equalToSuperview().inset(24)
            $0.leading.equalToSuperview()
        }
        self.sectionTimePaddingView.snp.makeConstraints{
            $0.centerY.equalTo(seminarSectionLabel.snp.centerY)
            $0.height.equalTo(26)
            $0.trailing.equalToSuperview()
        }
        self.sectionTimeImageView.snp.makeConstraints{
            $0.width.height.equalTo(13)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(9)
        }
        self.sectionTimeLabel.snp.makeConstraints{
            $0.centerY.equalTo(self.sectionTimeImageView.snp.centerY)
            $0.leading.equalTo(self.sectionTimeImageView.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().inset(8)
        }
    }
}
