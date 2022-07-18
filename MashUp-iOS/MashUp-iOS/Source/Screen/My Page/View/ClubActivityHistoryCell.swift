//
//  AttendanceEventCell.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/06/18.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_Core
import MashUp_UIKit
import UIKit


enum ScoreChangeStyle: Hashable {
    case addition(String)
    case deduction(String)
    case custom(String)
}

struct ClubActivityHistoryCellModel: Hashable {
    let id: String = UUID().uuidString
    let description: String
    let clubActivityStyle: ClubActivityStyle
    let scoreChangeStyle: ScoreChangeStyle
    let appliedTotalScoreText: String
}

final class ClubActivityHistoryCell: BaseTableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupAttribute()
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: ClubActivityHistoryCellModel) {
        self.historyTitleLabel.text = model.clubActivityStyle.title
        self.clubActivityImageView.image = model.clubActivityStyle.icon
        self.descriptionLabel.text = model.description
        self.appliedTotalScoreLabel.text = model.appliedTotalScoreText
        self.apply(style: model.scoreChangeStyle)
    }
    
    private func apply(style: ScoreChangeStyle) {
        switch style {
        case .addition(let changedScoreText):
            self.changedScoreLabel.textColor = .blue500
            self.changedScoreLabel.text = changedScoreText
        case .deduction(let changedScoreText):
            self.changedScoreLabel.textColor = .red500
            self.changedScoreLabel.text = changedScoreText
        case .custom(let changedScoreText):
            self.changedScoreLabel.textColor = .black
            self.changedScoreLabel.text = changedScoreText
        }
    }
    
    private let clubActivityImageView = UIImageView()
    private let historyTitleLabel = UILabel()
    private let dateLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let changedScoreLabel = UILabel()
    private let appliedTotalScoreLabel = UILabel()
    
}
extension ClubActivityHistoryCell {
    
    private func setupAttribute() {
        self.selectionStyle = .none
        self.backgroundColor = .gray50
        self.clubActivityImageView.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 12
        }
        self.historyTitleLabel.do {
            $0.text = ""
            $0.font = .pretendardFont(weight: .bold, size: 16)
            $0.textColor = .gray800
        }
        self.dateLabel.do {
            $0.text = ""
            $0.font = .pretendardFont(weight: .regular, size: 12)
            $0.textColor = .gray500
        }
        self.descriptionLabel.do {
            $0.text = ""
            $0.font = .pretendardFont(weight: .regular, size: 12)
            $0.textColor = .gray500
        }
        self.changedScoreLabel.do {
            $0.text = ""
            $0.font = .pretendardFont(weight: .bold, size: 16)
        }
        self.appliedTotalScoreLabel.do {
            $0.text = ""
            $0.textColor = .gray500
            $0.font = .pretendardFont(weight: .regular, size: 12)
        }
    }
    
    private func setupLayout() {
        self.contentView.addSubview(self.clubActivityImageView)
        self.clubActivityImageView.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.leading.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview().inset(12)
        }
        self.contentView.addSubview(self.historyTitleLabel)
        self.historyTitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.clubActivityImageView)
            $0.leading.equalTo(self.clubActivityImageView.snp.trailing).offset(12)
        }
        self.contentView.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints {
            $0.leading.equalTo(self.clubActivityImageView.snp.trailing).offset(12)
            $0.bottom.equalTo(self.clubActivityImageView)
        }
        self.contentView.addSubview(self.descriptionLabel)
        self.descriptionLabel.snp.makeConstraints {
            $0.leading.equalTo(self.clubActivityImageView.snp.trailing).offset(12)
            $0.bottom.equalTo(self.clubActivityImageView)
        }
        self.contentView.addSubview(self.changedScoreLabel)
        self.changedScoreLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(self.historyTitleLabel)
        }
        self.contentView.addSubview(self.appliedTotalScoreLabel)
        self.appliedTotalScoreLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.clubActivityImageView)
        }
    }
    
}
