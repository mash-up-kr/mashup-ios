//
//  SignUpStep2ViewController.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/06/10.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import ReactorKit
import MashUp_Core
import MashUp_UIKit

final class SignUpStep2ViewController: BaseViewController, View {
    
    typealias Reactor = SignUpStep2Reactor
    
    var disposeBag = DisposeBag()
    
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
        self.nameField.rx.text.orEmpty
            .distinctUntilChanged()
            .skip(1)
            .map { .didEditNameField($0) }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        self.platformSelectControl.rx.controlEvent(.touchUpInside)
            .map { .didTapSelectControl }
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
    }
    
    private func render(_ reactor: Reactor) {
        reactor.state.map { $0.canDone }
            .distinctUntilChanged()
            .bind(to: self.doneButton.rx.isEnabled)
            .disposed(by: self.disposeBag)
        
        reactor.state.map { $0.name }
            .distinctUntilChanged()
            .bind(to: self.nameField.rx.text)
            .disposed(by: self.disposeBag)
        
        reactor.state.compactMap { $0.selectedPlatformTeam }
            .distinctUntilChanged()
            .bind(to: self.platformSelectControl.rx.selectedMenu)
            .disposed(by: self.disposeBag)
    }
    
    private func consume(_ reactor: Reactor) {
        reactor.pulse(\.$shouldShowMenu)
            .compactMap { $0 }
            .onMain()
            .subscribe(onNext: { [weak self] platforms in self?.showPlatformTeamList(platforms) })
            .disposed(by: self.disposeBag)
        
        reactor.pulse(\.$shouldGoBack)
            .compactMap { $0 }
            .onMain()
            .subscribe(onNext: { [weak self] in self?.navigationController?.popViewController(animated: true) })
            .disposed(by: self.disposeBag)
    }
    
    private func showPlatformTeamList(_ platforms: [PlatformTeamSelectViewModel]) {
        let actionSheet = MUActionSheetController(title: "플랫폼 선택")
        let actions = platforms.enumerated().map { index, platform in
            MUActionSheetItem(
                title: platform.description,
                style: platform.isSelected ? .selected : .default,
                handler: { [reactor] _ in reactor?.action.onNext(.didSelectPlatformTeam(at: index)) }
            )
        }
        actions.forEach { actionSheet.addAction($0) }
        actionSheet.present(on: self)
    }
    
    private let navigationBar = MUNavigationBar()
    private let titleLabel = UILabel()
    private let nameField = MUTextField()
    private let platformSelectControl = MUSelectControl<PlatformTeamMenuViewModel>()
    private let doneButton = MUButton(frame: .zero, style: .primary)
    private let keyboardFrameView = KeyboardFrameView()
    
}
extension SignUpStep2ViewController {
    
    private func setupAttribute() {
        self.view.backgroundColor = .white
        self.navigationBar.do {
            $0.title = "회원가입"
            $0.leftBarItem = .back
        }
        self.titleLabel.do {
            $0.text = "이름과 플랫폼을 입력해주세요"
            $0.font = .pretendardFont(weight: .bold, size: 24)
        }
        self.nameField.do {
            $0.keyboardType = .namePhonePad
            $0.placeholder = "이름"
        }
        self.platformSelectControl.do {
            $0.menuTitle = "플랫폼"
            $0.selectedMenu = nil
        }
        self.doneButton.do {
            $0.setTitle("다음", for: .normal)
        }
    }
    
    private func setupLayout() {
        self.view.addSubview(self.navigationBar)
        self.navigationBar.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.height.equalTo(56)
        }
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.equalTo(self.navigationBar.snp.bottom).offset(12)
        }
        self.view.addSubview(self.nameField)
        self.nameField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(24)
        }
        self.view.addSubview(self.platformSelectControl)
        self.platformSelectControl.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(self.nameField.snp.bottom).offset(24)
        }
        self.view.addSubview(self.doneButton)
        self.doneButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(52)
        }
        self.view.addSubview(self.keyboardFrameView)
        self.keyboardFrameView.snp.makeConstraints {
            $0.top.equalTo(self.doneButton.snp.bottom)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
}
