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
import MashUp_Core
import MashUp_UIKit
import MashUp_PlatformTeam
import MashUp_Auth

final class SignInViewController: BaseViewController, ReactorKit.View {
    typealias Reactor = SignInReactor
    
    #warning("DIContainer 적용 후 제거되어야합니다 - booung")
    var authenticationResponder: AuthenticationResponder?
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func bind(reactor: Reactor) {
        self.dispatch(to: reactor)
        self.render(reactor)
        self.consume(reactor)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.view.endEditing(true)
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
        
        reactor.pulse(\.$step).compactMap { $0 }
            .onMain()
            .subscribe(onNext: { [weak self] in self?.move(to: $0) })
            .disposed(by: self.disposeBag)
        
    }
    
    private let idField = MUTextField()
    private let passwordField = MUTextField()
    private let signInButton = MUButton()
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
        self.view.backgroundColor = .white
        self.idField.do {
            $0.placeholder = "아이디"
            $0.keyboardType = .default
        }
        self.passwordField.do {
            $0.placeholder = "비밀번호"
            $0.keyboardType = .default
            $0.isSecureTextEntry = true
        }
        self.signInButton.do {
            $0.setTitle("로그인", for: .normal)
        }
        self.signUpButton.do {
            $0.titleLabel?.font = .pretendardFont(weight: .regular, size: 16)
            $0.setTitle("회원가입 하러가기", for: .normal)
            $0.setTitleColor(.gray600, for: .normal)
            $0.setImage(.ic_chevron_right?.resized(side: 20).withTintColor(.gray400), for: .normal)
            $0.semanticContentAttribute = .forceRightToLeft
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
        }
        self.signUpButton.snp.makeConstraints {
            $0.height.equalTo(56)
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
            $0.setCustomSpacing(4, after: self.signInButton)
            $0.addArrangedSubview(self.signUpButton)
        }
        self.view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).inset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        self.view.addSubview(self.loadingIndicator)
        self.loadingIndicator.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
}

// MARK: Navigation
extension SignInViewController {
    
    private func move(to step: SignInStep) {
        switch step {
        case .signUp:
            self.pushSignUpViewController()
        }
    }
    
    private func pushSignUpViewController() {
        let viewController = self.createSignUpViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func createSignUpViewController() -> SignUpStep1ViewController {
        let verificationService = VerificationServiceImpl()
        let reactor = SignUpStep1Reactor(verificationService: verificationService)
        let viewController = SignUpStep1ViewController()
        viewController.reactor = reactor
        #warning("DIContainer 적용 후 제거되어야합니다 - booung")
        viewController.authenticationResponder = self.authenticationResponder
        return viewController
    }
    
}

