//
//  MembershipWithdrawalViewController.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/07/07.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_Core
import ReactorKit
import MashUp_UIKit
import RxOptional

final class MembershipWithdrawalViewController: BaseViewController, ReactorKit.View {
    private let navigationBar: MUNavigationBar = MUNavigationBar()
    private let realLeavingLabel: UILabel = UILabel()
    private let confirmTextField: MUTextField = MUTextField()
    private let dontForgetView: DontForgetMashUpView = DontForgetMashUpView()
    private let withdrawalButton: MUButton = MUButton()
    private let keyboardFrameView: KeyboardFrameView = KeyboardFrameView()
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func bind(reactor: MembershipWithdrawalReactor) {
        confirmTextField.rx.text.orEmpty
            .skip(1)
            .distinctUntilChanged()
            .map { .didEditConfirmTextField($0) }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        let isValidatedObservable = reactor.state.compactMap { $0.isValidated }
            .distinctUntilChanged()
            .onMain()
            .share()
            
        isValidatedObservable
            .map { $0 ? .vaild : .invaild }
            .bind(to: confirmTextField.rx.status)
            .disposed(by: disposeBag)
        
        isValidatedObservable
            .bind(to: withdrawalButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        reactor.pulse { $0.$isSuccessfulWithdrawal }
            .compactMap { $0 }
            .onMain()
            .subscribe(onNext: {
                $0 ? print("회원탈퇴성공") : print("회원탈퇴실패")
            })
            .disposed(by: disposeBag)
        
        reactor.pulse { $0.$error }
            .compactMap { $0 }
            .onMain()
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupUI() {
        setupLayout()
        setupAttribute()
    }
    
    private func setupLayout() {
        view.addSubview(navigationBar)
        view.addSubview(realLeavingLabel)
        view.addSubview(confirmTextField)
        view.addSubview(dontForgetView)
        view.addSubview(withdrawalButton)
        view.addSubview(keyboardFrameView)
        
        navigationBar.snp.makeConstraints {
            $0.height.equalTo(56)
            $0.leading.top.trailing.equalToSuperview()
        }
        realLeavingLabel.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(12)
            $0.leading.equalToSuperview().offset(20)
        }
        confirmTextField.snp.makeConstraints {
            $0.top.equalTo(realLeavingLabel.snp.bottom).offset(20)
            $0.leading.equalTo(realLeavingLabel)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(106)
        }
        dontForgetView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-100)
        }
        keyboardFrameView.snp.makeConstraints {
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
        }
        withdrawalButton.snp.makeConstraints {
            $0.bottom.equalTo(keyboardFrameView.snp.top).offset(-28)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(52)
        }
    }
    
    private func setupAttribute() {
        view.backgroundColor = .gray50
        navigationBar.do {
            $0.title = "회원탈퇴"
            $0.leftBarItem = .back
        }
        realLeavingLabel.do {
            $0.text = "정말 떠나시나요...?"
            $0.font = .pretendardFont(weight: .bold, size: 24)
            $0.textColor = .gray800
        }
        confirmTextField.do {
            $0.assistiveDescription = "위 문구를 입력해주세요."
            $0.errorAssistiveDescription = "문구가 동일하지 않아요"
            $0.placeholder = "탈퇴할게요"
        }
        withdrawalButton.do {
            $0.setTitle("탈퇴하기", for: .normal)
            $0.isEnabled = false
        }
    }
}
