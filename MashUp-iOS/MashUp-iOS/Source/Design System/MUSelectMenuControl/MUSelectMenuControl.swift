//
//  MUSelectMenuView.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/05/31.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import Then
import SnapKit

protocol MUMenu: CaseIterable, CustomStringConvertible {}

class MUSelectMenuControl<Menu: MUMenu>: UIControl {
    
    var menuTitle: String? {
        get { self.menuTitleLabel.text }
        set { self.menuTitleLabel.text = newValue }
    }
    
    var selectedMenu: Menu? {
        didSet { self.updateUI() }
    }
    
    
    init(
        frame: CGRect = .zero,
        menuTitle: String?,
        hasIcon: Bool = true
    ) {
        super.init(frame: frame)
        
        self.setupLayout()
        self.setupAttribute()
        self.menuTitle = menuTitle
        self.updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 320, height: 84)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.roundCorner()
        self.drawBorder()
    }
    
    private func roundCorner() {
        self.layer.cornerRadius = 12
        self.layer.masksToBounds = true
    }
    
    private func drawBorder(borderColor: UIColor = .gray300) {
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 1
    }
    
    private func updateUI() {
        if let selectedMenu = self.selectedMenu {
            self.menuTitleLabel.isHidden = true
            self.selectedMenuLabel.text = selectedMenu.description
            self.selectedMenuLabel.textColor = .gray800
        } else {
            self.menuTitleLabel.isHidden = true
            self.selectedMenuLabel.text = self.menuTitle
            self.selectedMenuLabel.textColor = .gray400
        }
    }
    
    private let menuTitleLabel = UILabel()
    private let selectedMenuLabel = UILabel()
    private let iconImageView = UIImageView()
    
}
extension MUSelectMenuControl {
    
    private func setupAttribute() {
        self.menuTitleLabel.do {
            $0.textColor = .gray600
            $0.font = .pretendardFont(weight: .medium, size: 13)
        }
        self.selectedMenuLabel.do {
            $0.textColor = .gray800
            $0.font = .pretendardFont(weight: .medium, size: 20)
        }
        self.iconImageView.do {
            $0.image = UIImage(systemName: "chevron.down")
        }
    }
    
    private func setupLayout() {
        self.snp.makeConstraints {
            $0.width.equalTo(320).priority(.low)
            $0.height.equalTo(84).priority(.low)
        }
        let containerView = UIStackView().then {
            $0.axis = .vertical
        }
        self.addSubview(containerView)
        containerView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        containerView.addArrangedSubview(self.menuTitleLabel)
        self.menuTitleLabel.snp.makeConstraints {
            $0.width.equalTo(280)
            $0.height.equalTo(20)
        }
        containerView.addArrangedSubview(self.selectedMenuLabel)
        self.selectedMenuLabel.snp.makeConstraints {
            $0.width.equalTo(280)
            $0.height.equalTo(32)
        }
        containerView.addSubview(self.iconImageView)
        self.iconImageView.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.centerY.trailing.equalTo(self.selectedMenuLabel)
        }
    }
    
}
