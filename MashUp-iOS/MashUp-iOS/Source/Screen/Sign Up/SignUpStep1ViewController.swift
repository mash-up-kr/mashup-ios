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

final class SignUpStep1ViewController: BaseViewController, ReactorKit.View {
    
    typealias Reactor = SignUpStep1Reactor
    
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
        
        self.platformSelectControl.rx.controlEvent(.touchUpInside)
            .map { .didTapPlatformSelectControl }
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
        
        reactor.state.map { $0.passwordCheck }
            .distinctUntilChanged()
            .filter { [passwordCheckField] in passwordCheckField.text != $0 }
            .onMain()
            .bind(to: self.passwordCheckField.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state.compactMap { $0.selectedPlatform }
            .distinctUntilChanged()
            .map { PlatformTeamMenuViewModel(model: $0) }
            .onMain()
            .bind(to: self.platformSelectControl.rx.selectedMenu)
            .disposed(by: self.disposeBag)
    }
    
    private func consume(_ reactor: Reactor) {
        reactor.pulse(\.$shouldShowOnBottomSheet)
            .compactMap { $0 }
            .onMain()
            .subscribe(onNext: { [weak self] allPlatform in
                self?.presentPopup(platformTeams: allPlatform)
            })
            .disposed(by: self.disposeBag)
    }
    
    private func presentPopup(platformTeams: [PlatformTeam]) {
        #warning("프로토 타이핑 디자인 확인 후 추가 작업 필요 - Booung")
        let actionSheet = UIAlertController(
            title: "플랫폼",
            message: .empty,
            preferredStyle: .actionSheet
        )
        platformTeams.map { PlatformTeamMenuViewModel(model: $0) }
            .enumerated()
            .map { index, menu in
                UIAlertAction(title: menu.description, style: .default) { [reactor] _ in
                    reactor?.action.onNext(.didSelectPlatform(at: index))
                }
            }
            .forEach { actionSheet.addAction($0) }
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        self.present(actionSheet, animated: true)
    }
    
    private let navigationBar = MUNavigationBar()
    private let scrollView = UIScrollView()
    private let containterView = UIStackView()
    
    private let titleLabel = UILabel()
    private let idField = MUTextField()
    private let passwordField = MUTextField()
    private let passwordCheckField = MUTextField()
    private let platformSelectControl = MUSelectControl<PlatformTeamMenuViewModel>()
    private let keyboardFrameView = KeyboardFrameView()
    private let doneButton = MUButton()
}

extension SignUpStep1ViewController {
    
    private func setupAttribute() {
        self.view.backgroundColor = .white
        self.navigationBar.do {
            $0.title = "회원가입"
            #warning("Image 정의되면 수정해야합니다. - Booung")
            $0.leftIcon = UIImage(systemName: "chevron.backward")?.withTintColor(.gray900)
        }
        self.scrollView.do {
            $0.isScrollEnabled = false
            $0.showsVerticalScrollIndicator = false
            $0.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        }
        self.containterView.do {
            $0.backgroundColor = .red500
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
        self.passwordCheckField.do {
            $0.placeholder = "비밀번호 확인"
        }
        self.platformSelectControl.do {
            $0.menuTitle = "플랫폼"
        }
        self.doneButton.do {
            $0.setTitle("다음", for: .normal)
        }
        self.keyboardFrameView.do {
            $0.backgroundColor = .green500
        }
        Observable.merge(
            NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification),
            NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
        ).compactMap { notification in
            notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        }.subscribe(onNext:{ [scrollView] offset in
            scrollView.contentOffset.y = offset.height
        }).disposed(by: self.disposeBag)
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
            $0.addArrangedSubview(self.platformSelectControl)
        }
        self.view.addSubview(self.doneButton)
        self.doneButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        self.view.addSubview(self.keyboardFrameView)
        self.keyboardFrameView.snp.makeConstraints {
            $0.top.equalTo(self.doneButton.snp.bottom)
            $0.width.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        
    }
    
}
