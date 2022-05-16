//
//  InteractiveTextField.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/05/16.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxOptional

final class InteractiveTextField: UIView {
    enum Theme {
        case normal, focus, error
    }
    
    private let inputAreaView: UIView = UIView()
    private let placeholderLabel: UILabel = UILabel()
    private let textField: UITextField = UITextField()
    private let tailImageView: UIImageView = UIImageView()
    private let assistiveLabel: UILabel = UILabel()
    var validation: ((String?) -> Bool)?
    private var disposeBag: DisposeBag = DisposeBag()
    private lazy var exclamationMarkIcon: UIImage? = UIImage(systemName: "exclamationmark")
    private lazy var checkMarkIcon: UIImage? = UIImage(systemName: "checkmark")
    private let themeObservable: BehaviorRelay<Theme> = BehaviorRelay(value: .normal)
    private var animation: UIViewPropertyAnimator?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
        bind()
        setupAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(placeholder: String? = nil, assistText: String? = nil, validation: ((String?) -> Bool)? = nil) {
        self.init(frame: .zero)
        self.placeholderLabel.text = placeholder
        self.assistiveLabel.text = assistText
        self.validation = validation
    }
    
    private func setupUI() {
        inputAreaView.layer.borderWidth = 1
        inputAreaView.backgroundColor = .white
    }
    
    private func setupLayout() {
        addSubview(inputAreaView)
        inputAreaView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(84)
        }
        
        inputAreaView.addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(26)
            $0.height.equalTo(32)
        }
        
        inputAreaView.addSubview(textField)
        textField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(16)
            $0.height.equalTo(32)
        }
        
        inputAreaView.addSubview(tailImageView)
        tailImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalTo(textField)
            $0.width.height.equalTo(20)
        }
        
        addSubview(assistiveLabel)
        assistiveLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(4)
            $0.top.equalTo(inputAreaView.snp.bottom).offset(8)
        }
    }
    
    private func bind() {
        textField.rx.controlEvent(.editingDidBegin)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.placeholderAnimation(isReversed: false)
                owner.themeObservable.accept(.focus)
            })
            .disposed(by: disposeBag)
        
        textField.rx.controlEvent(.editingDidEnd)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.placeholderAnimation(isReversed: true)
                owner.themeObservable.accept(.normal)
            })
            .disposed(by: disposeBag)
        
        textField.rx.text
            .withUnretained(self)
            .compactMap { owner, text in
                return owner.validation?(text)
            }
            .withUnretained(self)
            .subscribe(onNext: { owner, validation in
                owner.changeViewFromValidation(validation)
            })
            .disposed(by: disposeBag)
        
        themeObservable
            .withUnretained(self)
            .subscribe(onNext: { owner, theme in
                let themeEntity = owner.makeTheme(theme)
                owner.setTheme(themeEntity)
            })
            .disposed(by: disposeBag)
    }
    
    private func setupAnimation() {
        animation = UIViewPropertyAnimator(duration: 0.3, curve: .linear) {
            self.placeholderLabel.transform = .init(scaleX: 20/32, y: 20/32)
            self.placeholderLabel.frame.origin.x = 20
            self.placeholderLabel.frame.origin.y = 16
            self.inputAreaView.layoutIfNeeded()
        }
        animation?.pausesOnCompletion = true
    }
    private func placeholderAnimation(isReversed: Bool) {
        animation?.isReversed = isReversed
        animation?.startAnimation()
    }
    
    private func changeViewFromValidation(_ isValidation: Bool) {
        if isValidation {
            tailImageView.image = checkMarkIcon
        } else {
            tailImageView.image = exclamationMarkIcon
            themeObservable.accept(.error)
        }
    }
    
    private func makeTheme(_ theme: Theme) -> InteractiveTextFieldTheme {
        switch theme {
        case .normal: return DefaultTextFieldTheme()
        case .focus: return FocusTextFieldTheme()
        case .error: return ErrorTextFieldTheme()
        }
    }
    
    private func setTheme(_ theme: InteractiveTextFieldTheme) {
        inputAreaView.layer.borderColor = theme.borderColor.cgColor
        assistiveLabel.textColor = theme.assistiveTextColor
        placeholderLabel.textColor = theme.placeholderColor
    }
}

protocol InteractiveTextFieldTheme {
    var borderColor: UIColor { get }
    var assistiveTextColor: UIColor { get }
    var placeholderColor: UIColor { get }
}

struct ErrorTextFieldTheme: InteractiveTextFieldTheme {
    let borderColor: UIColor = .red
    let assistiveTextColor: UIColor = .red
    let placeholderColor: UIColor = .red
}

struct FocusTextFieldTheme: InteractiveTextFieldTheme {
    let borderColor: UIColor = .purple
    let assistiveTextColor: UIColor = .gray
    let placeholderColor: UIColor = .black
}

struct DefaultTextFieldTheme: InteractiveTextFieldTheme {
    let borderColor: UIColor = .gray
    let assistiveTextColor: UIColor = .gray
    let placeholderColor: UIColor = .black
}
