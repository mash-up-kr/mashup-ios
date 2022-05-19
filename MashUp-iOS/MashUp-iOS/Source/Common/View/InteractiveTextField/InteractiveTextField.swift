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
    let textField: UITextField = UITextField()
    fileprivate let tailImageView: UIImageView = UIImageView()
    private let assistiveLabel: UILabel = UILabel()
    
    fileprivate let themeObservable: BehaviorRelay<Theme> = BehaviorRelay(value: .normal)
    private var animation: UIViewPropertyAnimator?
    private var disposeBag: DisposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        bind()
        setupAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(placeholder: String? = nil,
                     assistText: String? = nil) {
        self.init(frame: .zero)
        self.placeholderLabel.text = placeholder
        self.assistiveLabel.text = assistText
    }
    
    private func setupUI() {
        setupAttribute()
        setupLayout()
    }
    
    private func setupAttribute() {
        inputAreaView.layer.borderWidth = 1
        inputAreaView.backgroundColor = .white
        inputAreaView.layer.cornerRadius = 12
        placeholderLabel.font = .systemFont(ofSize: 20, weight: .medium)
        textField.font = .systemFont(ofSize: 20, weight: .medium)
        assistiveLabel.font = .systemFont(ofSize: 12)
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
            })
            .disposed(by: disposeBag)
        
        textField.rx.controlEvent(.editingDidEndOnExit)
            .withUnretained(self)
            .subscribe(onNext: { owner, _ in
                owner.placeholderAnimation(isReversed: true)
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
        animation = UIViewPropertyAnimator(duration: 0.2, curve: .linear) { [weak self] in
            let scale: CGFloat = 20/32
            self?.placeholderLabel.transform = .init(scaleX: scale, y: scale)
            self?.placeholderLabel.frame.origin.x = 20
            self?.placeholderLabel.frame.origin.y = 16
            self?.inputAreaView.layoutIfNeeded()
        }
        animation?.pausesOnCompletion = true
    }
    
    private func placeholderAnimation(isReversed: Bool) {
        if textField.hasText {
            return
        }
        animation?.isReversed = isReversed
        animation?.startAnimation()
    }
    
    private func makeTheme(_ theme: Theme) -> InteractiveTextFieldTheme {
        switch theme {
        case .normal:
            return InteractiveTextFieldTheme(borderColor: .gray, assistiveTextColor: .gray, placeholderColor: .black)
        case .focus:
            return InteractiveTextFieldTheme(borderColor: .purple, assistiveTextColor: .gray, placeholderColor: .black)
        case .error:
            return InteractiveTextFieldTheme(borderColor: .red, assistiveTextColor: .red, placeholderColor: .black)
        }
    }
    
    private func setTheme(_ theme: InteractiveTextFieldTheme) {
        inputAreaView.layer.borderColor = theme.borderColor.cgColor
        assistiveLabel.textColor = theme.assistiveTextColor
        placeholderLabel.textColor = theme.placeholderColor
    }
    
    func setTailImage(_ image: UIImage) {
        tailImageView.image = image
    }
    
    func setTheme(_ theme: Theme) {
        themeObservable.accept(theme)
    }
}

extension InteractiveTextField {
    var theme: Binder<Theme> {
        Binder(self) { view, theme in
            view.themeObservable.accept(theme)
        }
    }

    var tailImage: Binder<UIImage> {
        Binder(self) { view, image in
            view.tailImageView.image = image
        }
    }
}
