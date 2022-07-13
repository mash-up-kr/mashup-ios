//
//  TermsConditionAgreementPopupViewController.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/06/11.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import SnapKit
import ReactorKit
import MashUp_Core
import MashUp_UIKit
import MashUp_User
import MashUp_SignUpCode

final class TermsAgreementPopupViewController: BaseViewController, View {
    
    typealias Reactor = TermsAgreementReactor
    
    var disposeBag: DisposeBag = DisposeBag()
    
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
    
    func bind(reactor: Reactor) {
        self.dispatch(to: reactor)
        self.render(reactor)
        self.consume(reactor)
    }
    
    private func dispatch(to reactor: Reactor) {
        self.termsAgreementView.rx.didTapAcceptArea
            .map { _ in .didTapAcceptArea }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.termsAgreementView.rx.didTapSeeMoreButton
            .map { _ in .didTapSeeMore }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.confirmButton.rx.tap
            .map { .didTapConfirm }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    private func render(_ reactor: Reactor) {
        reactor.state.map { $0.hasAgreed }
            .distinctUntilChanged()
            .onMain()
            .bind(to: self.termsAgreementView.rx.hasAgreed)
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.canDone }
            .distinctUntilChanged()
            .onMain()
            .bind(to: self.confirmButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
    }
    
    private func consume(_ reactor: Reactor) {
        reactor.pulse(\.$step)
            .compactMap { $0 }
            .onMain()
            .subscribe(onNext: { step in
                
            })
            .disposed(by: self.disposeBag)
        
        reactor.pulse(\.$shouldClose)
            .compactMap { $0 }
            .onMain()
            .subscribe(onNext: { [weak self] in self?.dismiss(animated: true) })
            .disposed(by: self.disposeBag)
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

extension TermsAgreementPopupViewController {
    
    private func move(to step: TermsAgreementStep) {
        switch step {
        case .personalPrivacyPolicy:
            self.presentPersonalPrivacyPolicy()
        }
    }
    
    private func presentPersonalPrivacyPolicy() {
        #warning("개인정보약관 처리 화면 구현 해야합니다. - booung")
    }
    
}
