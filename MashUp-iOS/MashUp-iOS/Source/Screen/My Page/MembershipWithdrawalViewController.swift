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

public final class MembershipWithdrawalViewController: BaseViewController, ReactorKit.View {
    private let navigationBar: MUNavigationBar = MUNavigationBar()
    private let realLeavingLabel: UILabel = UILabel()
    private let confirmTextField: MUTextField = MUTextField()
    private let dontForgetView: DontForgetMashUpView = DontForgetMashUpView()
    private let withdrawalButton: MUButton = MUButton()
    
    public var disposeBag: DisposeBag = DisposeBag()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    public func bind(reactor: MembershipWithdrawalReactor) {
        confirmTextField.rx.text
            .filter { $0?.count ?? 0 > 0 }
            .map { $0 != "12" ? MUTextField.Status.focus : MUTextField.Status.invaild }
            .bind(to: confirmTextField.rx.status)
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
        withdrawalButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-28)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(52)
        }
    }
    
    private func setupAttribute() {
        view.backgroundColor = .white
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
    }
}

final class DontForgetMashUpView: BaseView {
    private let topImageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupLayout()
        setupAttribute()
    }
    
    private func setupLayout() {
        addSubview(topImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        topImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(topImageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func setupAttribute() {
        self.do {
            $0.backgroundColor = .gray100
            $0.layer.cornerRadius = 12
        }
        titleLabel.do {
            $0.text = "매시업을 잊지말아죠..."
            $0.font = .pretendardFont(weight: .bold, size: 16)
            $0.textColor = .gray800
        }
        descriptionLabel.do {
            $0.text = "탈퇴하시면 Admin에 저장된 모든 관련정보는 탈퇴일자 기준으로 3년간 보관된 후 삭제됩니다. 삭제된 정보는 복구할 수 없으니 신중하게 결정해주세요."
            $0.font = .pretendardFont(weight: .regular, size: 14)
            $0.textColor = .gray600
            $0.numberOfLines = 0
        }
    }
}
