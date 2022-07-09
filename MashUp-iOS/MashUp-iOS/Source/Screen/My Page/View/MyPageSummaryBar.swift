//
//  MyPageSummaryBar.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/06/18.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_Core
import MashUp_UIKit
import SnapKit
import Then


@objc protocol MyPageSummaryBarDelegate: AnyObject {
    @objc optional func myPageHeaderViewDidTapQuestionMarkButton(_ view: MyPageSummaryBar)
}

struct MyPageSummaryBarModel {
    let userName: String
    let totalScoreText: String
}

final class MyPageSummaryBar: BaseView {
    
    weak var delegate: MyPageSummaryBarDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
        self.setupAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: MyPageSummaryBarModel) {
        self.userNameLabel.text = model.userName
        self.totalAttendanceScoreLabel.text = model.totalScoreText
    }
    
    @objc private func didTapQuestionMarkButton(_ sender: Any) {
        self.delegate?.myPageHeaderViewDidTapQuestionMarkButton?(self)
    }
    
    private let userNameLabel = UILabel()
    private let scoreTitleLabel = UILabel()
    private let questionMarkButton = UIButton()
    private let totalAttendanceScoreLabel = UILabel()
    
}

extension MyPageSummaryBar {
    
    private func setupAttribute() {
        self.backgroundColor = .gray900
        self.userNameLabel.do {
            $0.font = .pretendardFont(weight: .bold, size: 16)
            $0.textColor = .gray100
        }
        self.scoreTitleLabel.do {
            $0.font = .pretendardFont(weight: .bold, size: 14)
            $0.textColor = .gray100
            $0.text = "총 출석점수"
        }
        self.questionMarkButton.do {
            let questionMarkImage = UIImage.info?.resized(width: 14, height: 14).withTintColor(.white)
            $0.setImage(questionMarkImage, for: .normal)
            $0.addTarget(self, action: #selector(didTapQuestionMarkButton(_:)), for: .touchUpInside)
        }
        self.totalAttendanceScoreLabel.do {
            $0.font = .pretendardFont(weight: .bold, size: 24)
            $0.textColor = .gray100
        }
    }
    
    private func setupLayout() {
        self.addSubview(self.userNameLabel)
        self.addSubview(self.scoreTitleLabel)
        self.userNameLabel.snp.makeConstraints {
            $0.bottom.equalTo(self.scoreTitleLabel.snp.top).offset(-10)
            $0.leading.equalToSuperview().inset(20)
        }
        self.scoreTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(21)
        }
        self.addSubview(self.questionMarkButton)
        self.questionMarkButton.snp.makeConstraints {
            $0.leading.equalTo(self.scoreTitleLabel.snp.trailing).offset(-9)
            $0.centerY.equalTo(self.scoreTitleLabel)
            $0.width.height.equalTo(40)
        }
        self.addSubview(self.totalAttendanceScoreLabel)
        self.totalAttendanceScoreLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(21)
        }
    }
    
}
