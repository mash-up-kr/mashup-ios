//
//  TermsConditionAgreementPopupViewController.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/06/11.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import SnapKit
import MashUp_Core
import MashUp_UIKit

final class TermsAgreementPopupViewController: BaseViewController {
    
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupAttribute()
        self.setupLayout()
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.dismiss(animated: false)
    }
    
    func present(on viewController: UIViewController, completion: (() -> Void)? = nil)  {
        viewController.present(self, animated: false, completion: {
            self.slideUp(completion: completion)
        })
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        self.slideDown(completion: {
            super.dismiss(animated: flag, completion: completion)
        })
    }
    
    private func slideUp(completion: (() -> Void)? = nil) {
        self.popupConstraint?.update(offset: 0)
        UIView.animate(
            withDuration: 0.3,
            animations: { self.view.layoutIfNeeded() },
            completion: { _ in completion?() }
        )
    }
    
    private func slideDown(completion: (() -> Void)? = nil) {
        self.popupConstraint?.update(offset: 500)
        UIView.animate(
            withDuration: 0.3,
            animations: { self.view.layoutIfNeeded() },
            completion: { _ in completion?() }
        )
    }
    
    private let popupContentView = EventHookingStackView()
    private let topBarView = UIView()
    private let titleLabel = UILabel()
    private let closeButton = UIButton()
    private let separatorView = UIView()
    private let termsAgreementView = TermsAgreementView()
    private let confirmButton = MUButton()
    private var popupConstraint: Constraint?
    
}
extension TermsAgreementPopupViewController {
    
    private func setupAttribute() {
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        self.popupContentView.do {
            $0.axis = .vertical
            $0.backgroundColor = .white
            $0.layer.masksToBounds = true
            $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            $0.layer.cornerRadius = 12
        }
        self.topBarView.do {
            $0.backgroundColor = .white
        }
        self.titleLabel.do {
            $0.font = .pretendardFont(weight: .semiBold, size: 16)
            $0.text = "필수 약관 동의"
        }
        self.closeButton.do {
            $0.setBackgroundImage(UIImage(named: "name=xmark, color=gray900, size=Default"), for: .normal)
        }
        self.separatorView.do {
            $0.backgroundColor = .gray200
        }
        self.termsAgreementView.do {
            $0.title = "개인정보처리방침 동의하기"
        }
        self.confirmButton.do {
            $0.setTitle("확인", for: .normal)
        }
    }
    
    private func setupLayout() {
        self.view.addSubview(self.popupContentView)
        self.popupContentView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            self.popupConstraint = $0.bottom.equalToSuperview().offset(500).constraint
        }
        self.popupContentView.addArrangedSubview(self.topBarView)
        self.topBarView.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        self.topBarView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        self.topBarView.addSubview(self.closeButton)
        self.closeButton.snp.makeConstraints {
            $0.width.height.equalTo(44)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
        self.topBarView.addSubview(self.separatorView)
        self.separatorView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        self.topBarView.addSubview(self.separatorView)
        self.popupContentView.addArrangedSubview(self.termsAgreementView)
        self.termsAgreementView.snp.makeConstraints {
            $0.height.equalTo(56)
        }
        let confirmButtonContainerView = UIView()
        self.popupContentView.addArrangedSubview(confirmButtonContainerView)
        confirmButtonContainerView.addSubview(self.confirmButton)
        self.confirmButton.snp.makeConstraints {
            $0.top.equalToSuperview().inset(36)
            $0.height.equalTo(52)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview()
        }
        let safeAreaButtomView = UIView()
        safeAreaButtomView.snp.makeConstraints {
            $0.height.equalTo(safeAreaBottomPadding)
        }
        self.popupContentView.addArrangedSubview(safeAreaButtomView)
    }
    
}
