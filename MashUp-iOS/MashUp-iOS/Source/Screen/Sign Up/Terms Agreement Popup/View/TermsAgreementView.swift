//
//  TermsAgreementView.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/06/12.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxGesture
import RxCocoa
import MashUp_Core
import MashUp_UIKit

@objc protocol TermsAgreementViewDelegate: AnyObject {
    @objc optional func termsAgreementView(_ view: TermsAgreementView, didTapAcceptArea currentTermsAgreement: Bool)
    @objc optional func termsAgreementView(_ view: TermsAgreementView, didTapSeeMoreButton currentTermsAgreement: Bool)
}

final class TermsAgreementView: BaseView {
    
    var title: String? {
        didSet { self.updateUI() }
    }
    var hasAgreed: Bool = false {
        didSet { self.updateUI() }
    }
    
    weak var delegate: TermsAgreementViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupAttribute()
        self.setupLayout()
        self.setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let disposeBag = DisposeBag()
    
    private let titleLabel = UILabel()
    private let checkImageView = UIImageView()
    private let checkBackgroundView = UIView()
    private let seeMoreButton = UIButton()
    
}
extension TermsAgreementView {
    
    private func setupAttribute() {
        self.checkBackgroundView.do {
            $0.layer.masksToBounds = true
            $0.layer.cornerRadius = 10
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray200.cgColor
        }
        self.checkImageView.do {
            $0.backgroundColor = .clear
            $0.image = .ic_check
        }
        self.titleLabel.do {
            $0.textColor = .gray700
            $0.font = .pretendardFont(weight: .semiBold, size: 14)
        }
        let attributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.font: UIFont.pretendardFont(weight: .medium, size: 12),
            NSAttributedString.Key.foregroundColor: UIColor.gray400.cgColor
        ]
        self.seeMoreButton.do {
            $0.contentHorizontalAlignment = .trailing
            $0.setAttributedTitle(NSAttributedString(string: "자세히", attributes: attributes), for: .normal)
        }
    }
    
    private func setupLayout() {
        self.addSubview(self.checkBackgroundView)
        self.checkBackgroundView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(20)
            $0.leading.equalToSuperview().inset(20)
        }
        self.addSubview(self.checkImageView)
        self.checkImageView.snp.makeConstraints {
            $0.center.equalTo(self.checkBackgroundView)
            $0.width.height.equalTo(20)
        }
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.leading.equalTo(self.checkBackgroundView.snp.trailing).offset(8)
            $0.centerY.equalToSuperview()
        }
        self.addSubview(self.seeMoreButton)
        self.seeMoreButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(44)
        }
    }
    
    private func setupAction() {
        self.rx.tapGesture()
            .when(.recognized)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.delegate?.termsAgreementView?(owner, didTapAcceptArea: owner.hasAgreed)
            })
            .disposed(by: self.disposeBag)
        
        self.seeMoreButton.rx.tap
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.delegate?.termsAgreementView?(owner, didTapSeeMoreButton: owner.hasAgreed)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func updateUI() {
        self.titleLabel.text = self.title
        if self.hasAgreed {
            self.checkImageView.imageTintColor = .white
            self.checkBackgroundView.layer.borderWidth = 0
            self.checkBackgroundView.backgroundColor = .brand600
        } else {
            self.checkImageView.imageTintColor = .gray200
            self.checkBackgroundView.layer.borderWidth = 1
            self.checkBackgroundView.backgroundColor = .white
        }
    }
    
}
