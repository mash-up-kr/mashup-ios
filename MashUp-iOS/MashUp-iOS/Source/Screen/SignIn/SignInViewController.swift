//
//  SignInViewController.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/24.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import ReactorKit
import RxCocoa
import RxSwift
import SnapKit
import Then
import UIKit

final class SignInViewController: BaseViewController, ReactorKit.View {
    typealias Reactor = SignInReactor
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func bind(reactor: Reactor) {
        self.dispatch(to: reactor)
        self.render(reactor)
        self.consume(reactor)
    }
    
    private func dispatch(to reactor: Reactor) {
        self.idField.rx.text.orEmpty
            .map { .didEditIDField($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.passwordField.rx.text.orEmpty
            .map { .didEditPasswordField($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    private func render(_ reactor: Reactor) {
        reactor.state.map { $0.id }
        .distinctUntilChanged()
        .bind(to: self.idField.rx.text)
        .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.password }
        .distinctUntilChanged()
        .bind(to: self.passwordField.rx.text)
        .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.isLoading }
        .distinctUntilChanged()
        .bind(to: self.loadingIndicator.rx.isAnimating)
        .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.canTrySignIn }
        .distinctUntilChanged()
        .bind(to: self.signInButton.rx.isEnabled)
        .disposed(by: self.disposeBag)
    }
    
    private func consume(_ reactor: Reactor) {
        
    }
    
    private let idField = UITextField()
    private let passwordField = UITextField()
    private let signInButton = UIButton()
    private let signUpButton = UIButton()
    private let loadingIndicator = UIActivityIndicatorView()
}
// MARK: Setup
extension SignInViewController {
    
    private func setupUI() {
        self.setupAttribute()
        self.setupLayout()
    }
    
    private func setupAttribute() {
        self.idField.do {
            $0.keyboardType = .default
            $0.placeholder = "아이디를 입력해주세요"
        }
        self.passwordField.do {
            $0.keyboardType = .default
            $0.placeholder = "비밀번호를 입력해주세요"
            $0.isSecureTextEntry = true
        }
        self.signInButton.do {
            $0.setTitle("로그인", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.backgroundColor = .systemIndigo
        }
        self.signUpButton.do {
            $0.setTitle("회원가입", for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.backgroundColor = .white
        }
    }
    
    private func setupLayout() {
        self.signInButton.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.width.equalTo(250)
        }
        self.signUpButton.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.width.equalTo(250)
        }
        
        let stackView = UIStackView().then {
            $0.alignment = .fill
            $0.axis = .vertical
            $0.spacing = 8
        }
        stackView.do {
            $0.addArrangedSubview(self.idField)
            $0.addArrangedSubview(self.passwordField)
            $0.addArrangedSubview(self.signInButton)
            $0.addArrangedSubview(self.signUpButton)
        }
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        self.view.addSubview(self.loadingIndicator)
        self.loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}