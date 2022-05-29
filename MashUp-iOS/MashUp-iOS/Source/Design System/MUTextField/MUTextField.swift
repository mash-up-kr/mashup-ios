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
        set { self.placeholderLabel.text = newValue }
    }
    
    var assistiveDescription: String? {
        get { self.assistiveLabel.text }
        set {
            self.assistiveLabel.text = newValue
            self.assistiveView.isHidden = newValue.isEmptyOrNil == true
        }
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
    
    enum AnimationDirection {
        case forward
        case reverse
    }
    
    private func didUpdateStatus(to status: Status, from oldStatus: Status) {
        let style = MUTextFieldStyle(status: status)
        
        if let animationDirection = self.animationDirection(from: status, to: oldStatus) {
            switch animationDirection {
            case .forward:
                animator.isReversed = false
                animator.startAnimation()
            case .reverse:
                animator.isReversed = true
                animator.startAnimation()
            }
            animator.pausesOnCompletion = true
        }
        
        self.applyStyle(style)
    }
    
    private func animationDirection(from oldStatus: Status, to newStatus: Status) -> AnimationDirection? {
        switch (oldStatus, newStatus) {
        case (.inactive, _): return .reverse
        case (_, .inactive): return .forward
        default: return nil
        }
    }
    
    private func applyStyle(_ style: MUTextFieldStyle) {
        self.textAreaView.layer.borderColor = style.borderColor.cgColor
        self.textField.textColor = style.textColor
        self.textField.font = style.textFont
        self.placeholderLabel.textColor = style.placeholderColor
        self.assistiveLabel.textColor = style.assistiveTextColor
        self.assistiveLabel.font = style.assistiveFont
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
            $0.height.equalTo(32)
            $0.bottom.equalToSuperview().inset(16)
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
        
        self.containerView.addArrangedSubview(self.assistiveView)
        self.assistiveView.addSubview(self.assistiveLabel)
        self.assistiveLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(4)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setupStream() {
        let inactive = self.textField.rx.controlEvent(.editingDidEnd)
            .filter { [textField] in textField.text?.isEmpty == true }
            .map { Status.inactive }
        
        let active = self.textField.rx.controlEvent(.editingDidEnd)
            .filter { [textField] in textField.text?.isNotEmpty == true }
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
    private let assistiveView = UIView()
    private let assistiveLabel = UILabel()
    private let trailingIconImageView = UIImageView()
    
    private let disposeBag = DisposeBag()
    
    private lazy var animator = UIViewPropertyAnimator(duration: 0.2, curve: .linear) { [placeholderLabel, textAreaView] in
        let scale: CGFloat = 20/32
        placeholderLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
        placeholderLabel.frame.origin.x = 20
        placeholderLabel.frame.origin.y = 16
        textAreaView.layoutIfNeeded()
    }
    
}
