//
//  SignUpStep2ViewController.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/06/10.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_Core
import MashUp_UIKit

final class SignUpStep2ViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupAttribute()
        self.setupLayout()
    }
    
    private let navigationBar = MUNavigationBar()
    private let titleLabel = UILabel()
    private let nameField = MUTextField()
    private let platformSelectControl = MUSelectControl<PlatformTeamMenuViewModel>()
    private let doneButton = MUButton()
    
}
extension SignUpStep2ViewController {
    
    private func setupAttribute() {
        self.view.backgroundColor = .white
        self.navigationBar.do {
            $0.title = "회원가입"
            $0.leftIcon = UIImage(systemName: "chevron.backward")?.withTintColor(.gray900)
        }
        self.titleLabel.do {
            $0.text = "이름과 플랫폼을 입력해주세요"
            $0.font = .pretendardFont(weight: .bold, size: 24)
        }
        self.nameField.do {
            $0.placeholder = "이름"
        }
        self.platformSelectControl.do {
            $0.menuTitle = "플랫폼"
            $0.selectedMenu = nil
        }
        self.doneButton.do {
            $0.setTitle("다음", for: .normal)
        }
    }
    
    private func setupLayout() {
        self.view.addSubview(self.navigationBar)
        self.navigationBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(56)
        }
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(self.navigationBar.snp.bottom).offset(12)
        }
        self.view.addSubview(self.nameField)
        self.nameField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(24)
        }
        self.view.addSubview(self.platformSelectControl)
        self.platformSelectControl.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(self.nameField.snp.bottom).offset(24)
        }
        self.view.addSubview(self.doneButton)
        self.doneButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
}
