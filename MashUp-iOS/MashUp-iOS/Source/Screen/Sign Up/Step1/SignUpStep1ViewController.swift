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
import RxGesture
import UIKit
import SnapKit
import Then
import MashUp_Core
import MashUp_UIKit
import MashUp_PlatformTeam
import MashUp_Auth

final class SignUpStep1ViewController: BaseViewController, ReactorKit.View {
    
    typealias Reactor = SignUpStep1Reactor
    
    #warning("DIContainer 적용 후 제거되어야합니다 - booung")
    var authenticationResponder: AuthenticationResponder?
    
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
            .distinctUntilChanged()
            .skip(1)
            .map { .didEditIDField($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.passwordField.rx.text.orEmpty
            .distinctUntilChanged()
            .skip(1)
            .map { .didEditPasswordField($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.passwordCheckField.rx.text.orEmpty
            .distinctUntilChanged()
            .skip(1)
            .map { .didEditPasswordCheckField($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.navigationBar.leftButton.rx.tap
            .map { .didTapBack }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.doneButton.rx.tap
            .map { .didTapDoneButton }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.passwordCheckField.textField.rx.controlEvent(.editingDidBegin)
            .map { _ in .didFocusPasswordCheckField }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.passwordCheckField.textField.rx.controlEvent(.editingDidEnd)
            .map { _ in .didOutOfFocusPasswordCheckField }
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
        
        reactor.state.map { $0.passwordCheck }
            .distinctUntilChanged()
            .filter { [passwordCheckField] in passwordCheckField.text != $0 }
            .onMain()
            .bind(to: self.passwordCheckField.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.canScroll }
            .distinctUntilChanged()
            .onMain()
            .bind(to: self.scrollView.rx.isScrollEnabled)
            .disposed(by: self.disposeBag)
        
        Observable.merge(
            self.idField.textField.rx.controlEvent(.editingDidEndOnExit).map { [idField] in idField },
            self.passwordField.textField.rx.controlEvent(.editingDidEndOnExit).map { [passwordField] in passwordField }
        )
        .onMain()
        .subscribe(onNext: { [idField, passwordField, passwordCheckField] textField in
            switch textField {
            case idField:
                passwordField.becomeFirstResponder()
            case passwordField:
                passwordCheckField.becomeFirstResponder()
            default: ()
            }
        })
        .disposed(by: self.disposeBag)
    }
    
    private func consume(_ reactor: Reactor) {
        reactor.pulse(\.$shouldScrollToTop)
            .compactMap { $0 }
            .onMain()
            .withUnretained(self)
            .subscribe(onNext: { [scrollView] owner, _ in
                let offset = owner.topOffset
                scrollView.setContentOffset(offset, animated: true)
            })
            .disposed(by: self.disposeBag)
        
        reactor.pulse(\.$shouldFocusPasswordCheckField)
            .compactMap { $0 }
            .onMain()
            .withUnretained(self)
            .subscribe(onNext: { [scrollView] owner, _ in
                let offset = owner.passwordCheckFieldHighlightedOffset
                scrollView.setContentOffset(offset, animated: true)
            })
            .disposed(by: self.disposeBag)
        
        reactor.pulse(\.$shouldGoBackward)
            .compactMap { $0 }
            .onMain()
            .subscribe(onNext: { [weak self] in self?.goBackward() })
            .disposed(by: self.disposeBag)
        
        reactor.pulse(\.$step).compactMap { $0 }
            .onMain()
            .subscribe(onNext: { [weak self] step in
                self?.move(to: step)
            })
            .disposed(by: self.disposeBag)
    }
    
    private var topOffset: CGPoint {
        CGPoint(x: 0, y: -self.scrollView.contentInset.top)
    }
    
    private var passwordCheckFieldHighlightedOffset: CGPoint {
        let contentHeight = self.view.frame.height - self.navigationBar.frame.height
        let doneContainerHeight = self.doneButtonContainerView.frame.origin.y
        let passwordCheckFieldHeight = self.doneButtonContainerView.frame.height
        let keyboardHeight = self.keyboardFrameView.frame.height
        
        let y = contentHeight - passwordCheckFieldHeight - 76 - doneContainerHeight - keyboardHeight - 20
        return CGPoint(x: 0, y: -y)
    }
    
    private let navigationBar = MUNavigationBar()
    private let scrollView = EventThroughScrollView()
    private let containterView = EventThroughStackView()
    
    private let titleLabel = UILabel()
    private let idField = MUTextField()
    private let passwordField = MUTextField()
    private let passwordCheckField = MUTextField()
    private let keyboardFrameView = KeyboardFrameView()
    private let doneButtonContainerView = UIView()
    private let doneButton = MUButton()
    private let bottomView = EventThroughView()
}
extension SignUpStep1ViewController {
    
    private func move(to step: SignUpStep1Step) {
        switch step {
        case .signUpStep2(let id, let password):
            let reactor = SignUpStep2Reactor(id: id, password: password)
            let viewController = SignUpStep2ViewController()
            viewController.reactor = reactor
            #warning("DIContainer 적용 후 제거되어야합니다 - booung")
            viewController.authenticationResponder = authenticationResponder
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    private func goBackward() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension SignUpStep1ViewController {
    
    private func setupAttribute() {
        self.view.backgroundColor = .white
        self.navigationBar.do {
            $0.title = "회원가입"
            #warning("Image 정의되면 수정해야합니다. - Booung")
            $0.leftBarItem = .back
        }
        self.scrollView.do {
            $0.isScrollEnabled = false
            $0.showsVerticalScrollIndicator = false
            $0.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        }
        self.containterView.do {
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
            $0.isSecureTextEntry = true
        }
        self.passwordCheckField.do {
            $0.placeholder = "비밀번호 확인"
            $0.isSecureTextEntry = true
        }
        self.keyboardFrameView.do {
            $0.backgroundColor = .white
        }
        self.doneButton.do {
            $0.setTitle("다음", for: .normal)
        }
        self.doneButtonContainerView.do {
            $0.backgroundColor = .white
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
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.greaterThanOrEqualTo(500)
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
            $0.addArrangedSubview(self.passwordCheckField)
            $0.addArrangedSubview(self.bottomView)
        }
        self.bottomView.snp.makeConstraints {
            $0.height.equalTo(300)
        }
        self.view.addSubview(self.doneButtonContainerView)
        self.doneButtonContainerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(52)
        }
        self.doneButtonContainerView.addSubview(self.doneButton)
        self.doneButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalToSuperview()
        }
        self.view.addSubview(self.keyboardFrameView)
        self.keyboardFrameView.snp.makeConstraints {
            $0.top.equalTo(self.doneButtonContainerView.snp.bottom)
            $0.width.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
    }
    
}
