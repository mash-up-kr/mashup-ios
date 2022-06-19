//
//  MyPageHeaderView.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/06/18.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import MashUp_Core
import MashUp_UIKit
import SnapKit
import Then
import UIKit

@objc protocol MyPageHeaderViewDelegate: AnyObject {
    @objc optional func myPageHeaderViewDidTapSettingButton(_ view: MyPageHeaderView)
    @objc optional func myPageHeaderViewDidTapQuestionMarkButton(_ view: MyPageHeaderView)
}

struct MyPageHeaderViewModel {
    let userName: String
    let platformTeamText: String
    let totalScoreText: String
}

final class MyPageHeaderView: BaseView {
    
    weak var delegate: MyPageHeaderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupAttribute()
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: MyPageHeaderViewModel) {
        self.userNameLabel.text = viewModel.userName
        self.platformTeamLabel.text = viewModel.platformTeamText
        self.totalAttendanceScoreLabel.text = viewModel.totalScoreText
    }
    
    @objc private func didTapSettingButton(_ sender: Any) {
        self.delegate?.myPageHeaderViewDidTapSettingButton?(self)
    }
    
    @objc private func didTapQuestionMarkButton(_ sender: Any) {
        self.delegate?.myPageHeaderViewDidTapQuestionMarkButton?(self)
    }
    
    private let userNameLabel = UILabel()
    private let platformTeamLabel = UILabel()
    private let scoreContainerView = UIView()
    private let scoreTitleLabel = UILabel()
    private let questionMarkButton = UIButton()
    private let totalAttendanceScoreLabel = UILabel()
    private let mascotImageView = UIImageView()
    private let settingButton = UIButton()
    
}

extension MyPageHeaderView {
    
    private func setupAttribute() {
        self.backgroundColor = .gray50
        self.userNameLabel.do {
            $0.font = .pretendardFont(weight: .bold, size: 24)
            $0.textColor = .gray900
        }
        self.platformTeamLabel.do {
            $0.font = .pretendardFont(weight: .bold, size: 16)
            $0.textColor = .primary500
        }
        self.settingButton.do {
            $0.backgroundColor = .red500
            $0.addTarget(self, action: #selector(didTapSettingButton(_:)), for: .touchUpInside)
        }
        self.scoreTitleLabel.do {
            $0.font = .pretendardFont(weight: .bold, size: 14)
            $0.textColor = .gray400
            $0.text = "총 출석점수"
        }
        self.scoreContainerView.do {
            $0.backgroundColor = .white
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 12
            $0.addShadow(x: 0, y: 2, color: .black.withAlphaComponent(0.1), radius: 20)
        }
        self.totalAttendanceScoreLabel.do {
            $0.font = .pretendardFont(weight: .bold, size: 24)
            $0.textColor = .gray700
        }
        self.questionMarkButton.do {
            $0.backgroundColor = .gray700
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 6
            $0.setTitle("?", for: .normal)
            $0.setTitleColor(.gray100, for: .normal)
            $0.titleLabel?.font = .pretendardFont(weight: .bold, size: 8)
            $0.addTarget(self, action: #selector(didTapQuestionMarkButton(_:)), for: .touchUpInside)
        }
        self.mascotImageView.do {
            $0.image = UIImage(named: "mascot")
        }
    }
    
    private func setupLayout() {
        self.addSubview(self.userNameLabel)
        self.userNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(20)
        }
        self.addSubview(self.settingButton)
        self.settingButton.snp.makeConstraints {
            $0.centerY.equalTo(self.userNameLabel)
            $0.trailing.equalToSuperview().inset(24)
            $0.width.height.equalTo(20)
        }
        self.addSubview(self.platformTeamLabel)
        self.platformTeamLabel.snp.makeConstraints {
            $0.top.equalTo(self.userNameLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(20)
        }
        self.addSubview(self.scoreContainerView)
        self.scoreContainerView.snp.makeConstraints {
            $0.top.equalTo(self.platformTeamLabel.snp.bottom).offset(36)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(76)
        }
        self.addSubview(self.mascotImageView)
        self.mascotImageView.snp.makeConstraints {
            $0.bottom.equalTo(self.scoreContainerView.snp.top).offset(22)
            $0.trailing.equalTo(self.scoreContainerView).offset(-14)
            $0.width.equalTo(80)
            $0.height.equalTo(64)
        }
        self.scoreContainerView.addSubview(self.scoreTitleLabel)
        self.scoreTitleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(24)
        }
        self.scoreContainerView.addSubview(self.questionMarkButton)
        self.questionMarkButton.snp.makeConstraints {
            $0.leading.equalTo(self.scoreTitleLabel.snp.trailing).offset(4)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(12)
        }
        self.scoreContainerView.addSubview(self.totalAttendanceScoreLabel)
        self.totalAttendanceScoreLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(24)
        }
    }
    
}