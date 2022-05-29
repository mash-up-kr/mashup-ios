//
//  MUTextField.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/05/29.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
import Then

class MUTextField: UIControl {
    
    enum Status: Equatable {
        case inactive
        case active
        case focus
        case vaild
        case invaild
        case disable
        case custom(MUTextFieldStyle)
    }
    
    let textField = UITextField()
    
    var text: String? {
        get { self.textField.text }
        set { self.textField.text = newValue }
    }
    
    var keyboardType: UIKeyboardType {
        get { self.textField.keyboardType }
        set { self.textField.keyboardType = newValue }
    }
    
    var placeholder: String? {
        get { self.placeholderLabel.text }
        set {
            self.placeholderLabel.text = newValue
            self.textField.placeholder = newValue
        }
    }
    
    var assistiveDescription: String? {
        get { self.assistiveLabel.text }
        set { self.assistiveLabel.text = newValue }
    }
    
    var isSecureTextEntry: Bool {
        get { self.textField.isSecureTextEntry }
        set { self.textField.isSecureTextEntry = newValue }
    }
    
    var status: MUTextField.Status {
        didSet { self.didUpdateStatus(to: self.status, from: oldValue) }
    }
    
    init(frame: CGRect = .zero, status: MUTextField.Status = .inactive) {
        self.status = status
        super.init(frame: frame)
        let style = MUTextFieldStyle(status: self.status)
        self.setupAttribute()
        self.setupLayout()
        self.setupStream()
        self.applyStyle(style)
    }
    
    required init?(coder: NSCoder) {
        self.status = .inactive
        super.init(coder: coder)
        self.setupAttribute()
        self.setupLayout()
        self.setupStream()
    }
    
    private func needsAnimate(from oldStatus: Status, to newStatus: Status) -> Bool {
        return true
    }
    
    private func didUpdateStatus(to status: Status, from oldStatus: Status) {
        let style = MUTextFieldStyle(status: status)
        self.applyStyle(style)
    }
    
    private func applyStyle(_ style: MUTextFieldStyle) {
        self.textAreaView.layer.borderColor = style.borderColor.cgColor
        self.textField.textColor = style.textColor
        self.textField.font = style.textFont
        self.placeholderLabel.textColor = style.placeholderColor
        self.placeholderLabel.font = style.placeholderFont
        self.assistiveLabel.textColor = style.assistiveTextColor
        self.trailingIconImageView.image = style.trailingIconImage
    }
    
    private func setupAttribute() {
        self.textAreaView.layer.do {
            $0.masksToBounds = true
            $0.cornerRadius = 12
            $0.borderWidth = 1
        }
        self.containerView.do {
            $0.axis = .vertical
            $0.spacing = 8
        }
        let style = MUTextFieldStyle(status: self.status)
        self.applyStyle(style)
    }
    
    private func setupLayout() {
        self.addSubview(self.containerView)
        self.containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.containerView.addArrangedSubview(self.textAreaView)
        self.textAreaView.snp.makeConstraints {
            $0.height.equalTo(84)
        }
        
        self.textAreaView.addSubview(self.textField)
        self.textField.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(32)
        }
        
        self.textAreaView.addSubview(self.placeholderLabel)
        self.placeholderLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().offset(26)
            $0.height.equalTo(32)
        }
        
        self.textAreaView.addSubview(self.trailingIconImageView)
        self.trailingIconImageView.snp.makeConstraints {
            $0.centerY.equalTo(self.textField)
            $0.width.height.trailing.equalTo(20)
        }
        
        self.containerView.addArrangedSubview(self.assistiveLabel)
    }
    
    private func setupStream() {
        let inactive = self.textField.rx.controlEvent(.editingDidEnd)
            .filter { [text] in text?.isEmpty == true }
            .map { Status.inactive }
        
        let active = self.textField.rx.controlEvent(.editingDidEnd)
            .filter { [text] in text?.isNotEmpty == true }
            .map { Status.active }
        
        let focus = self.textField.rx.controlEvent(.editingDidBegin)
            .map { Status.focus }
        
        Observable.merge(inactive, active, focus)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] in self?.status = $0 })
            .disposed(by: self.disposeBag)
    }
    
    private let containerView = UIStackView()
    private let textAreaView = UIView()
    private let placeholderLabel = UILabel()
    private let assistiveLabel = UILabel()
    private let trailingIconImageView = UIImageView()
    
    private let disposeBag = DisposeBag()
    
}
