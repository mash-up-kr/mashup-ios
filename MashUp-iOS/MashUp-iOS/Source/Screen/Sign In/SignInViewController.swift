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
        
        self.signInButton.rx.tap
            .map { .didTapSignInButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.signUpButton.rx.tap
            .map { .didTapSignUpButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    private func render(_ reactor: Reactor) {
        reactor.state.map { $0.id }
        .distinctUntilChanged()
        .onMain()
        .bind(to: self.idField.rx.text)
        .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.password }
        .distinctUntilChanged()
        .onMain()
        .bind(to: self.passwordField.rx.text)
        .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.isLoading }
        .distinctUntilChanged()
        .onMain()
        .bind(to: self.loadingIndicator.rx.isAnimating)
        .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.canTryToSignIn }
        .distinctUntilChanged()
        .onMain()
        .bind(to: self.signInButton.rx.isEnabled)
        .disposed(by: self.disposeBag)
    }
    
    private func consume(_ reactor: Reactor) {
        reactor.pulse(\.$alertMessage).compactMap { $0 }
            .onMain()
            .withUnretained(self)
            .subscribe(onNext: { owner, message in
                let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default)
                alertController.addAction(ok)
                owner.present(alertController, animated: true)
            })
            .disposed(by: self.disposeBag)
    }
    
    private let idField = InteractiveTextField(placeholder: "아이디",
                                               assistText: "아이디1")
    private let passwordField = InteractiveTextField(placeholder: "비밀번호",
                                                     assistText: "비밀번호1")
    private let signInButton = MUButton()
    private let signUpButton = MUButton()
    private let loadingIndicator = UIActivityIndicatorView()
}
// MARK: Setup
extension SignInViewController {
    
    private func setupUI() {
        self.setupAttribute()
        self.setupLayout()
    }
    
    private func setupAttribute() {
        self.view.backgroundColor = .white
        self.idField.do {
            $0.textField.keyboardType = .default
        }
        self.passwordField.do {
            $0.textField.keyboardType = .default
            $0.textField.isSecureTextEntry = true
        }
        self.signInButton.do {
            $0.setTitle("로그인", for: .normal)
        }
        self.signUpButton.do {
            $0.setTitle("회원가입 하러가기", for: .normal)
        }
        self.loadingIndicator.do {
            $0.hidesWhenStopped = true
            $0.style = .medium
            $0.tintColor = .white
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
            $0.top.equalToSuperview().inset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        self.view.addSubview(self.loadingIndicator)
        self.loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}
