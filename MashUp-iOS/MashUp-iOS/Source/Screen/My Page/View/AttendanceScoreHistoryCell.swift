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


enum ScoreChangeStyle {
    case addition(String)
    case deduction(String)
    case custom(String)
}

struct AttendanceScoreHistoryCellModel {
    let historyTitle: String
    let scoreChangeStyle: ScoreChangeStyle
    let appliedTotalScoreText: String
}

final class AttendanceScoreHistoryCell: BaseTableViewCell {
    
    func configure(with model: AttendanceScoreHistoryCellModel) {
        self.historyTitleLabel.text = model.historyTitle
        self.appliedTotalScoreLabel.text = model.appliedTotalScoreText
        self.apply(style: model.scoreChangeStyle)
        #warning("프로토타이핑 - booung")
        self.eventColorView.backgroundColor = [.blue500, .green500, .red500, .primary500].randomElement()!
    }
    
    private func apply(style: ScoreChangeStyle) {
        switch style {
        case .addition(let changedScoreText):
            self.changedScoreLabel.textColor = .blue500
            self.changedScoreLabel.text = changedScoreText
        case .deduction(let changedScoreText):
            self.changedScoreLabel.text = changedScoreText
        case .custom(let changedScoreText):
            self.changedScoreLabel.text = changedScoreText
        }
    }
    
    private let eventColorView = UIView()
    private let historyTitleLabel = UILabel()
    private let dateLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let changedScoreLabel = UILabel()
    private let appliedTotalScoreLabel = UILabel()
    
}
extension AttendanceScoreHistoryCell {
    
    private func setupAttribute() {
        self.eventColorView.do {
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
        
    }
    
}
