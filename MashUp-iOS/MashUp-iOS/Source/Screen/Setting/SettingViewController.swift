//
//  SettingViewController.swift
//  MashUp-iOS
//
//  Created by 이문정 on 2022/07/15.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_Core
import MashUp_UIKit
import RxSwift
import RxCocoa
import ReactorKit

final class SettingViewController: BaseViewController, View {
    
    typealias Reactor = SettingReactor
    
    var disposeBag: DisposeBag = DisposeBag()
    
    private let navigationBar: MUNavigationBar = MUNavigationBar(frame: .zero)
    private let settingMenuStackView: UIStackView = UIStackView()
    private let snsLeftStackView: UIStackView = UIStackView()
    private let snsRightStackView: UIStackView = UIStackView()
    private let snsContainerStacView: UIStackView = UIStackView()
    private let logoutButton = SettingMenuView(title: "로그아웃", titleColor: .gray800)
    private let withdrawalButton = SettingMenuView(title: "회원탈퇴", titleColor: .red500, hasDisclosure: true)
    private let facebookButton = SNSButton(snsType: .facebook)
    private let instagramButton = SNSButton(snsType: .instagram)
    private let tistoryButton = SNSButton(snsType: .tistory)
    private let youtubeButton = SNSButton(snsType: .youtube)
    private let mashUpHomeButton = SNSButton(snsType: .home)
    private let recruitButton = SNSButton(snsType: .recruit)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func bind(reactor: Reactor) {
        self.dispatch(to: reactor)
        self.render(reactor)
        self.consume(reactor)
    }
    
    private func dispatch(to reactor: Reactor) {
        self.navigationBar.leftButton.rx.tap
            .map { .didTapBack }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.logoutButton.rx.tap
            .map { .didTapSignOut }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.withdrawalButton.rx.tap
            .map { .didTapWithdrawal }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.facebookButton.rx.tap
            .map { .didTapFacebook }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.instagramButton.rx.tap
            .map { .didTapInstagram }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.tistoryButton.rx.tap
            .map { .didTapTistory }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.youtubeButton.rx.tap
            .map { .didTapYoutube }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.mashUpHomeButton.rx.tap
            .map { .didTapHomepage }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.recruitButton.rx.tap
            .map { .didTapRecruit }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    private func render(_ reactor: Reactor) {
    }
    
    private func consume(_ reactor: Reactor) {
        reactor.pulse(\.$shouldGoBackward)
            .compactMap { $0 }
            .onMain()
            .subscribe(onNext: { [weak self] in self?.goBackward() })
            .disposed(by: self.disposeBag)
        
        reactor.pulse(\.$askUserToSignOut)
            .compactMap { $0 }
            .onMain()
            .subscribe(onNext: { [weak self] in self?.showAlertSignOut() })
            .disposed(by: self.disposeBag)
        
        
        reactor.pulse(\.$step)
            .compactMap { $0 }
            .onMain()
            .subscribe(onNext: { [weak self] step in self?.move(to: step) })
            .disposed(by: self.disposeBag)
    }
    
    private func goBackward() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func move(to step: SettingStep) {
        switch step {
        case .withdrawal:
            let viewController = self.makeMembershipWithdrawalViewController()
            self.navigationController?.pushViewController(viewController, animated: true)
            
        case .open(let url):
            guard UIApplication.shared.canOpenURL(url) else { return }
            UIApplication.shared.open(url)
        }
    }
    
    private func showAlertSignOut() {
        let alert = MUActionAlertViewController(title: "로그아웃을 하시겠습니까?")
        let cancel = MUAlertAction(title: "취소", style: .default)
        let confirm = MUAlertAction(title: "확인", style: .primary, handler: {
            self.reactor?.action.onNext(.didConfirmSignOut)
        })
        alert.addAction(cancel)
        alert.addAction(confirm)
        self.present(alert, animated: true)
    }
    
    private func makeMembershipWithdrawalViewController() -> UIViewController {
        let withdrawalService = MembershipWithdrawalServiceImpl()
        let withdrawalReactor = MembershipWithdrawalReactor(service: withdrawalService)
        let withdrawalViewController = MembershipWithdrawalViewController()
        withdrawalViewController.reactor = withdrawalReactor
        return withdrawalViewController
    }
    
}

extension SettingViewController {
    
    private func setupUI() {
        setupLayout()
        setupAttribute()
    }
    
    private func setupAttribute() {
        view.backgroundColor = .gray50
        navigationBar.do {
            $0.leftBarItem = .back
            $0.title = "설정"
        }
        settingMenuStackView.do {
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.spacing = 0
        }
        snsLeftStackView.do {
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.spacing = 8
        }
        snsRightStackView.do {
            $0.axis = .vertical
            $0.distribution = .fillEqually
            $0.spacing = 8
        }
        snsContainerStacView.do {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 8
        }
        
    }
    
    private func setupLayout() {
        view.addSubview(navigationBar)
        view.addSubview(settingMenuStackView)
        view.addSubview(snsContainerStacView)
        snsContainerStacView.addArrangedSubview(snsLeftStackView)
        snsContainerStacView.addArrangedSubview(snsRightStackView)
        navigationBar.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
        settingMenuStackView.snp.makeConstraints {
            $0.height.equalTo(112)
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        snsContainerStacView.snp.makeConstraints {
            $0.height.equalTo(238)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(48)
        }
        settingMenuStackView.addArrangedSubview(logoutButton)
        settingMenuStackView.addArrangedSubview(withdrawalButton)
        snsLeftStackView.addArrangedSubview(facebookButton)
        snsLeftStackView.addArrangedSubview(tistoryButton)
        snsLeftStackView.addArrangedSubview(mashUpHomeButton)
        snsRightStackView.addArrangedSubview(instagramButton)
        snsRightStackView.addArrangedSubview(youtubeButton)
        snsRightStackView.addArrangedSubview(recruitButton)
    }
}
