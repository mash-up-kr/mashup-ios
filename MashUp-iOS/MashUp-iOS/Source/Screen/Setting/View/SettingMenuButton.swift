//
//  SettingMenuView.swift
//  MashUp-iOS
//
//  Created by 이문정 on 2022/07/15.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import SnapKit
import Then
import UIKit
import MashUp_Core
import MashUp_UIKit
import RxSwift
import RxCocoa

final class SettingMenuView: BaseView {
    private let menuTitleLabel: UILabel = UILabel()
    private let menuTrailingImageView: UIImageView = UIImageView()
    private let separatorView: UIView = UIView()
    fileprivate let button: UIButton = UIButton()
    
    init(title: String, titleColor: UIColor) {
        super.init(frame: .zero)
        setupUI()
        menuTitleLabel.textColor = titleColor
        menuTitleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupLayout()
        setupAttribute()
    }
    
    private func setupAttribute() {
        menuTitleLabel.do {
            $0.font = .pretendardFont(weight: .semiBold, size: 16)
        }
        menuTrailingImageView.do {
            $0.backgroundColor = .red
        }
        separatorView.do {
            $0.backgroundColor = .gray100
        }
        button.do {
            $0.backgroundColor = .clear
        }
    }
    
    private func setupLayout() {
        self.addSubview(menuTitleLabel)
        self.addSubview(menuTrailingImageView)
        self.addSubview(separatorView)
        self.addSubview(button)
        menuTitleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
        menuTrailingImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.height.width.equalTo(20)
            $0.centerY.equalTo(menuTitleLabel.snp.centerY)
        }
        separatorView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        button.snp.makeConstraints {
            $0.leading.top.trailing.bottom.equalToSuperview()
        }
    }
}

extension Reactive where Base: SettingMenuView {
    var tap: ControlEvent<Void> {
        self.base.button.rx.tap
    }
}
