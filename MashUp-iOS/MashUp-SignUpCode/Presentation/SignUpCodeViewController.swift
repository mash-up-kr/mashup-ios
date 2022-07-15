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
import ReactorKit

public final class SignUpCodeViewController: BaseViewController, View {
    
    public typealias Reactor = SignUpCodeReactor
    
    public var disposeBag: DisposeBag = DisposeBag()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.setupAttribute()
        self.setupLayout()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    public func bind(reactor: Reactor) {
        self.dispatch(to: reactor)
        self.render(reactor)
        self.consume(reactor)
    }
    
    private func dispatch(to reactor: Reactor) {
        self.signUpCodeField.rx.text.orEmpty
            .map { .didEditSignUpCodeField($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.doneButton.rx.tap
            .map { .didTapDone }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.navigationBar.leftButton.rx.tap
            .map { .didTapBack }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.navigationBar.rightButton.rx.tap
            .map { .didTapClose }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    private func render(_ reactor: Reactor) {
        reactor.state.map { $0.canDone }
            .distinctUntilChanged()
            .bind(to: self.doneButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.hasWrongSignUpCode }
            .distinctUntilChanged()
            .map { $0 ? .focus : .invaild }
            .bind(to: self.signUpCodeField.rx.status)
            .disposed(by: self.disposeBag)
    }
    
    private func consume(_ reactor: Reactor) {
        reactor.pulse(\.$shouldReconfirmStopSigningUp)
            .compactMap { $0 }
            .onMain()
            .subscribe(onNext: { [weak self] _ in
                self?.presentAlertReconfirmStopSigningUp()
            })
            .disposed(by: self.disposeBag)
        
        reactor.pulse(\.$shouldGoBackward)
            .compactMap { $0 }
            .onMain()
            .subscribe(onNext: { [weak self] _ in self?.goBackward() })
            .disposed(by: self.disposeBag)
        
        reactor.pulse(\.$shouldClose)
            .compactMap { $0 }
            .onMain()
            .subscribe(onNext: { [weak self] _ in self?.close() })
            .disposed(by: self.disposeBag)
    }
    
    private func presentAlertReconfirmStopSigningUp() {
        let alert = UIAlertController(
            title: "회원가입을 그만두시겠어요?",
            message: "입력한 전체 내용이 삭제됩니다.",
            preferredStyle: .alert
        )
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default) { [reactor] _ in
            reactor?.action.onNext(.didTapStopSigningUp)
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
    private func goBackward() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func close() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    private let navigationBar = MUNavigationBar()
    private let titleLabel = UILabel()
    private let signUpCodeField = MUTextField()
    private let doneButton = MUButton()
    private let keyboardFrameView = KeyboardFrameView()
    
}
extension SignUpCodeViewController {
    
    private func setupAttribute() {
        self.view.backgroundColor = .white
        
        self.navigationBar.do {
            $0.title = "회원가입"
            $0.leftBarItem = .back
            $0.rightBarItem = .close
        }
        self.titleLabel.do {
            $0.text = "가입코드를 입력해주세요"
            $0.font = .pretendardFont(weight: .semiBold, size: 24)
        }
        self.signUpCodeField.do {
            $0.placeholder = "가입코드"
            $0.errorAssistiveDescription = "가입코드가 일치하지 않아요"
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
        }

    }
    
}
