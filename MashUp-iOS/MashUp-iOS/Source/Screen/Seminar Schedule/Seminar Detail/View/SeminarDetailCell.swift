//
//  SeminarDetailCell.swift
//  MashUp-iOS
//
//  Created by 이문정 on 2022/06/26.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import SnapKit
import Then
import UIKit
import MashUp_Core
import MashUp_UIKit

final class SeminarDetailCell: BaseCollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    func configure(with model: SeminarDetailCellModel, index: Int) {
        self.seminarTitleLabel.text = model.title
        self.timeLabel.text = model.time
        self.platformLabel.text = model.platform
        self.numberLabel.text = "\(index + 1)"
    }
    
    private let numberLabel = UILabel()
    private let seminarTitleLabel = UILabel()
    private let platformLabel = UILabel()
    private let timeLabel = UILabel()
    
    private func setupUI() {
        setupLayout()
        setupAttribute()
    }
    
    private func setupAttribute() {
        self.numberLabel.do {
            $0.textColor = .gray600
            $0.backgroundColor = .gray100
            $0.font = .pretendardFont(weight: .semiBold, size: 12)
            $0.textAlignment = .center
            $0.layer.cornerRadius = 10
            $0.clipsToBounds = true
        }
        self.seminarTitleLabel.do {
            $0.textColor = .gray700
            $0.font = .pretendardFont(weight: .semiBold, size: 16)
        }
        self.platformLabel.do {
            $0.textColor = .gray600
            $0.font = .pretendardFont(weight: .regular, size: 14)
        }
        self.timeLabel.do {
            $0.textColor = .gray400
            $0.font = .pretendardFont(weight: .regular, size: 13)
        }
        
    }
     
    private func setupLayout() {
        self.do {
            $0.addSubview(self.numberLabel)
            $0.addSubview(self.seminarTitleLabel)
            $0.addSubview(self.platformLabel)
            $0.addSubview(self.timeLabel)
        }
        self.numberLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.height.width.equalTo(20)
        }
        self.seminarTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.numberLabel.snp.top)
            $0.leading.equalTo(self.numberLabel.snp.trailing).offset(8)
        }
        self.platformLabel.snp.makeConstraints {
            $0.top.equalTo(self.seminarTitleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(self.seminarTitleLabel.snp.leading)
            $0.bottom.equalToSuperview()
        }
        self.timeLabel.snp.makeConstraints{
            $0.centerY.equalTo(self.seminarTitleLabel.snp.centerY)
            $0.trailing.equalToSuperview()
        }
    }
}
