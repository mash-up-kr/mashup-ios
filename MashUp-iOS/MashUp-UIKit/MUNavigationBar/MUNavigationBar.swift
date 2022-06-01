//
//  MUNavigationBar.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/05/30.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import SnapKit
import Then

public class MUNavigationBar: UIView {
    
    public let leftButton = UIButton()
    public let titleLabel = UILabel()
    public let rightButton = UIButton()
    
    public var style: MUNavigationBarStyle? {
        didSet { self.setupStyle() }
    }
    
    public var title: String? {
        get { self.titleLabel.text }
        set { self.titleLabel.text = newValue }
    }
    
    public var leftIcon: UIImage? {
        get { self.leftButton.image(for: .normal) }
        set { self.leftButton.setBackgroundImage(newValue, for: .normal) }
    }
    
    public var rightIcon: UIImage? {
        get { self.rightButton.image(for: .normal) }
        set { self.rightButton.setBackgroundImage(newValue, for: .normal) }
    }
    
    public override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.setupAttribute()
        self.setupLayout()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupAttribute()
        self.setupLayout()
    }
    
    public override var intrinsicContentSize: CGSize {
        CGSize(width: UIScreen.main.bounds.width, height: 56)
    }
    
    private func setupStyle() {
        self.titleLabel.font = self.style?.titleFont
        self.leftButton.setBackgroundImage(self.style?.leftIconImage, for: .normal)
        self.rightButton.setBackgroundImage(self.style?.rightIconImage, for: .normal)
        self.titleLabel.textColor = .gray900
    }
    
    private func setupAttribute() {
        self.titleLabel.font = .pretendardFont(weight: .semiBold, size: 16)
    }
    
    private func setupLayout() {
        self.addSubview(self.leftButton)
        self.leftButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(8)
        }
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.center.equalToSuperview()
        }
        self.addSubview(self.rightButton)
        self.rightButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(8)
        }
    }
    
}
