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

final class SettingViewController: BaseViewController {
    
    private let navigationBar: MUNavigationBar = MUNavigationBar(frame: .zero)
    private let settingMenuStackView: UIStackView = UIStackView()
    private let snsLeftStackView: UIStackView = UIStackView()
    private let snsRightStackView: UIStackView = UIStackView()
    private let snsContainerStacView: UIStackView = UIStackView()
    private let logoutButton: BaseView = SettingMenuView(title: "로그아웃", titleColor: .gray800)
    private let withdrawalButton: BaseView = SettingMenuView(title: "회원탈퇴", titleColor: .red500)
    private let facebookButton: BaseView = SNSButton(snsType: .facebook)
    private let instagramButton: BaseView = SNSButton(snsType: .instagram)
    private let tistoryButton: BaseView = SNSButton(snsType: .tistory)
    private let youtubeButton: BaseView = SNSButton(snsType: .youtube)
    private let mashUpHomeButton: BaseView = SNSButton(snsType: .home)
    private let recruitButton: BaseView = SNSButton(snsType: .recruit)
    private let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
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
