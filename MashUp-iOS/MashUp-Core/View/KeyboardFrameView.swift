//
//  KeyboardFrameView.swift
//  MashUp-Core
//
//  Created by Booung on 2022/06/03.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import RxSwift
import SnapKit

public class KeyboardFrameView: BaseView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupConstraint()
        self.reactiveKeyboardFrame()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraint() {
        self.snp.makeConstraints {
            $0.height.equalTo(0)
        }
    }
    
    private func reactiveKeyboardFrame() {
        Observable.merge(
            NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification),
            NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
        ).compactMap { notification in
          if notification.name == UIResponder.keyboardWillHideNotification { return .zero }
          else { return notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
        }.subscribe(onNext: { [weak self] keyboardFrame in
            self?.updateFrame(keyboardFrame)
        }).disposed(by: self.disposeBag)
    }
    
    private func updateFrame(_ frame: CGRect) {
        self.snp.updateConstraints {
            $0.height.equalTo(frame.height)
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.layoutIfNeeded()
        })
    }
    
    private let disposeBag = DisposeBag()
    
}

