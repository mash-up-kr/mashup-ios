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
import MashUp_PlatformTeam

@objc protocol MyPageHeaderViewDelegate: AnyObject {
    @objc optional func myPageHeaderViewDidTapSettingButton(_ view: MyPageHeaderView)
    @objc optional func myPageHeaderViewDidTapQuestionMarkButton(_ view: MyPageHeaderView)
    @objc optional func myPageHeaderViewDidTap5TimesMascotImage(_ view: MyPageHeaderView)
}

enum MyPagePlatformStyle: CaseIterable {
    case design
    case android
    case iOS
    case web
    case node
    case spring
    
    var mascotImage: UIImage? {
        switch self {
        case .design: return .img_profile_design
        case .android: return .img_profile_android
        case .iOS: return .img_profile_iOS
        case .web: return .img_profile_web
        case .node: return .img_profile_node
        case .spring: return .img_profile_spring
        }
    }
    var textColor: UIColor? {
        switch self {
        case .design: return UIColor(hexString: "#C5C0FF")
        case .android: return UIColor(hexString: "#B3D7B2")
        case .iOS: return UIColor(hexString: "#F5B8B8")
        case .web: return UIColor(hexString: "#BFD1FF")
        case .node: return UIColor(hexString: "#C0C0DB")
        case .spring: return UIColor(hexString: "#9DDDD5")
            
        }
    }
    var backgroundColor: UIColor? {
        switch self {
        case .design: return UIColor(hexString: "#8176FB", alpha: 0.3)
        case .android: return UIColor(hexString: "#58AE56", alpha: 0.3)
        case .iOS: return UIColor(hexString: "#D35C5C", alpha: 0.3)
        case .web: return UIColor(hexString: "#5A88FF", alpha: 0.3)
        case .node: return UIColor(hexString: "#6B6B80", alpha: 0.3)
        case .spring: return UIColor(hexString: "#259688", alpha: 0.3)
        }
    }
    
    init(platform: PlatformTeam) {
        switch platform {
        case .design:
            self = .design
        case .android:
            self = .android
        case .iOS:
            self = .iOS
        case .web:
            self = .web
        case .node:
            self = .node
        case .spring:
            self = .spring
        }
    }
    
}

struct MyPageHeaderViewModel: Equatable {
    let userName: String
    let platformTeamText: String
    let platformStyle: MyPagePlatformStyle
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
        self.platformTeamLabel.textColor = viewModel.platformStyle.textColor
        self.platformTeamLabel.backgroundColor = viewModel.platformStyle.backgroundColor
        self.mascotImageView.image = viewModel.platformStyle.mascotImage?.resized(width: 180, height: 146)
        self.totalClubActivityScoreLabel.text = viewModel.totalScoreText
    }
    
    @objc private func didTapSettingButton(_ sender: Any) {
        self.delegate?.myPageHeaderViewDidTapSettingButton?(self)
    }
    
    @objc private func didTapQuestionMarkButton(_ sender: Any) {
        self.delegate?.myPageHeaderViewDidTapQuestionMarkButton?(self)
    }
    
    @objc private func didTap10TimesMascot(_ sender: Any) {
        self.delegate?.myPageHeaderViewDidTap5TimesMascotImage?(self)
    }
    
    private let userNameLabel = UILabel()
    private let platformTeamLabel = PaddingLabel()
    private let scoreCardView = UIImageView()
    private let scoreTitleLabel = UILabel()
    private let questionMarkButton = UIButton()
    private let totalClubActivityScoreLabel = UILabel()
    private let mascotImageView = UIImageView()
    private let settingButton = UIButton()
    private let darkHalfBackgroundView = UIView()
}

extension MyPageHeaderView {
    
    private func setupAttribute() {
        self.darkHalfBackgroundView.do {
            $0.backgroundColor = .gray900
        }
        self.backgroundColor = .gray50
        self.userNameLabel.do {
            $0.font = .pretendardFont(weight: .bold, size: 24)
            $0.textColor = .white
        }
        self.platformTeamLabel.do {
            $0.font = .pretendardFont(weight: .medium, size: 14)
            $0.backgroundColor = .brand500
            $0.layer.cornerRadius = 13
            $0.layer.masksToBounds = true
            $0.textColor = .white
        }
        self.settingButton.do {
            let settingImage = UIImage.ic_setting?.resized(width: 24, height: 24).withTintColor(.white)
            $0.setImage(settingImage, for: .normal)
            $0.addTarget(self, action: #selector(didTapSettingButton(_:)), for: .touchUpInside)
        }
        self.scoreCardView.do {
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 12
            $0.isUserInteractionEnabled = true
            $0.addShadow(x: 0, y: 2, color: .black.withAlphaComponent(0.1), radius: 20)
            $0.image = .img_card_bg
        }
        self.totalClubActivityScoreLabel.do {
            $0.font = .pretendardFont(weight: .bold, size: 24)
            $0.textColor = .white
        }
        self.scoreTitleLabel.do {
            $0.font = .pretendardFont(weight: .bold, size: 16)
            $0.textColor = .white
            $0.text = "활동점수"
        }
        self.questionMarkButton.do {
            let questionMarkImage = UIImage.ic_info?.resized(width: 18, height: 18).withTintColor(.white)
            $0.setImage(questionMarkImage, for: .normal)
            $0.addTarget(self, action: #selector(didTapQuestionMarkButton(_:)), for: .touchUpInside)
        }
        let tap5TimesGesture = UITapGestureRecognizer(target: self, action: #selector(didTap10TimesMascot(_:))).then { $0.numberOfTapsRequired = 5 }
        self.mascotImageView.do {
            $0.image = UIImage(named: "img_profile_team")
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(tap5TimesGesture)
        }
        
    }
    
    private func setupLayout() {
        self.addSubview(self.darkHalfBackgroundView)
        self.darkHalfBackgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(308)
        }
        self.addSubview(self.settingButton)
        self.settingButton.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.trailing.equalToSuperview().inset(8)
            $0.width.height.equalTo(44)
        }
        let userInfoStackView = UIStackView().then {
            $0.alignment = .center
            $0.axis = .vertical
        }
        self.addSubview(self.scoreCardView)
        self.darkHalfBackgroundView.addSubview(userInfoStackView)
        userInfoStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.scoreCardView.snp.top).offset(-20)
        }
        userInfoStackView.addArrangedSubview(self.mascotImageView)
        self.mascotImageView.snp.makeConstraints {
            $0.width.equalTo(180)
            $0.height.equalTo(146)
        }
        userInfoStackView.setCustomSpacing(0, after: self.mascotImageView)
        userInfoStackView.addArrangedSubview(self.userNameLabel)
        userInfoStackView.setCustomSpacing(12, after: self.userNameLabel)
        userInfoStackView.addArrangedSubview(self.platformTeamLabel)
        
        self.scoreCardView.snp.makeConstraints {
            $0.top.equalTo(self.darkHalfBackgroundView.snp.bottom).offset(-72)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(114)
        }
        let stackView = UIStackView().then {
            $0.axis = .vertical
            $0.spacing = 4
        }
        stackView.addArrangedSubview(self.totalClubActivityScoreLabel)
        stackView.addArrangedSubview(self.scoreTitleLabel)
        self.scoreCardView.addSubview(self.questionMarkButton)
        self.questionMarkButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview()
            $0.width.height.equalTo(40)
        }
        self.scoreCardView.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}
