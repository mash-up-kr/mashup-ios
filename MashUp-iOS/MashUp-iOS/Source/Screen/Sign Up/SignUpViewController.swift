//
//  SignUpViewController.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/05/29.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import ReactorKit
import RxSwift
import RxCocoa
import UIKit
import SnapKit
import Then

final class SignUpViewController: BaseViewController, ReactorKit.View {
    
    typealias Reactor = SignUpReactor
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupAttribute()
        self.setupLayout()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.view.endEditing(true)
    }
    
    func bind(reactor: Reactor) {
        self.dispatch(to: reactor)
        self.render(reactor)
        self.consume(reactor)
    }
    
    private func dispatch(to reactor: Reactor) {
        self.idField.rx.text.orEmpty
            .skip(1)
            .map { .didEditIDField($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.passwordField.rx.text.orEmpty
            .skip(1)
            .map { .didEditPasswordField($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.nameField.rx.text.orEmpty
            .skip(1)
            .map { .didEditNameField($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.doneButton.rx.tap
            .map { .didTapDoneButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    private func render(_ reactor: Reactor) {
        reactor.state.map { $0.canDone }
            .distinctUntilChanged()
            .onMain()
            .bind(to: self.doneButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.id }
            .distinctUntilChanged()
            .filter { [idField] in idField.text != $0 }
            .onMain()
            .bind(to: self.idField.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state.compactMap { $0.hasVaildatedID }
            .distinctUntilChanged()
            .map { $0 ? .vaild : .invaild }
            .onMain()
            .bind(to: self.idField.rx.status)
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.password }
            .distinctUntilChanged()
            .filter { [passwordField] in passwordField.text != $0 }
            .onMain()
            .bind(to: self.passwordField.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state.compactMap { $0.hasVaildatedPassword }
            .distinctUntilChanged()
            .map { $0 ? .vaild : .invaild }
            .onMain()
            .bind(to: self.passwordField.rx.status)
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.name }
            .distinctUntilChanged()
            .filter { [nameField] in nameField.text != $0 }
            .onMain()
            .bind(to: self.nameField.rx.text)
            .disposed(by: self.disposeBag)
    }
    
    private func consume(_ reactor: Reactor) {}
    
    
    private func setupAttribute() {
        self.view.backgroundColor = .white
        self.navigationBar.do {
            $0.title = "회원가입"
            $0.leftIcon = UIImage(systemName: "chevron.backward")
        }
        self.scrollView.do {
            $0.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
            $0.isScrollEnabled = true
        }
        self.containterView.do {
            $0.backgroundColor = .white
            $0.axis = .vertical
        }
        self.titleLabel.do {
            $0.text = "회원정보를 입력해주세요"
            $0.font = .pretendardFont(weight: .bold, size: 24)
        }
        self.idField.do {
            $0.placeholder = "아이디"
            $0.assistiveDescription = "영문 대소문자만 사용하여 15자 이내로 입력해 주세요."
        }
        self.passwordField.do {
            $0.placeholder = "비밀번호"
            $0.assistiveDescription = "영문, 숫자를 조합하여 8자 이상으로 입력해 주세요."
        }
        self.nameField.do {
            $0.placeholder = "이름"
        }
        self.platformField.do {
            $0.placeholder = "플랫폼"
            $0.text = "iOS"
        }
        self.doneButton.do {
            $0.setTitle("다음", for: .normal)
        }
    }
    
    private func setupLayout() {
        self.view.addSubview(self.navigationBar)
        self.navigationBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
        }
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints {
            $0.top.equalTo(self.navigationBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
        }
        self.scrollView.addSubview(self.containterView)
        self.containterView.snp.makeConstraints {
            $0.top.bottom.equalTo(self.scrollView.contentLayoutGuide)
            $0.width.equalToSuperview()
        }
        self.containterView.do {
            $0.spacing = 12
            $0.addArrangedSubview(self.titleLabel)
            $0.setCustomSpacing(30, after: self.titleLabel)
            $0.addArrangedSubview(self.idField)
            $0.addArrangedSubview(self.passwordField)
            $0.addArrangedSubview(self.nameField)
            $0.addArrangedSubview(self.platformField)
        }
        self.view.addSubview(self.doneButton)
        self.doneButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private let navigationBar = MUNavigationBar()
    private let scrollView = UIScrollView()
    private let containterView = UIStackView()
    
    private let titleLabel = UILabel()
    private let idField = MUTextField()
    private let passwordField = MUTextField()
    private let nameField = MUTextField()
    private let platformField = MUTextField()
    private let doneButton = MUButton()
    
}
