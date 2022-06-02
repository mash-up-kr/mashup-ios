//
//  SignUpCodeViewController.swift
//  MashUp-SignUpCode
//
//  Created by Booung on 2022/06/02.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import Then
import SnapKit
import MashUp_Core
import MashUp_UIKit

public final class SignUpCodeViewController: BaseViewController {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAttribute()
        self.setupLayout()
    }
    
    private let navigationBar = MUNavigationBar()
    private let titleLabel = UILabel()
    private let signUpCodeField = MUTextField()
    private let doneButton = MUButton()
    private let keyboardFrameView = UIView()
    
    private var keyboardHeightConstraint: Constraint?
}
extension SignUpCodeViewController {
    
    private func setupAttribute() {
        self.view.backgroundColor = .white
        
        self.navigationBar.do {
            $0.title = "회원가입"
        }
        self.titleLabel.do {
            $0.text = "가입코드를 입력해주세요"
            $0.font = .pretendardFont(weight: .semiBold, size: 24)
        }
        self.signUpCodeField.do {
            $0.placeholder = "가입코드"
        }
        self.doneButton.do {
            $0.setTitle("완료", for: .normal)
        }
    }
    
    private func setupLayout() {
        self.view.addSubview(self.navigationBar)
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.signUpCodeField)
        self.view.addSubview(self.doneButton)
        self.view.addSubview(self.keyboardFrameView)
        
        self.navigationBar.snp.makeConstraints {
            $0.leading.trailing.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(56)
        }
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.navigationBar.snp.bottom).offset(12)
            $0.leading.equalTo(12)
        }
        self.signUpCodeField.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        self.doneButton.snp.makeConstraints {
            $0.height.equalTo(52)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(self.keyboardFrameView.snp.top).inset(12)
        }
        self.keyboardFrameView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
            self.keyboardHeightConstraint = $0.height.equalTo(0).constraint
        }

    }
}
