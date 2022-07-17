//
//  DotLabel.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/06/29.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_Core

final class DotLabel: BaseView {
    private let dotView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    
    var text: String? {
        get { titleLabel.text }
        set { titleLabel.text = newValue }
    }
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        setupLayout()
        setupAttribute()
    }
    
    private func setupLayout() {
        addSubview(dotView)
        addSubview(titleLabel)
        dotView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(4)
        }
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(dotView.snp.trailing).offset(8)
            $0.trailing.equalToSuperview()
            $0.top.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupAttribute() {
        titleLabel.do {
            $0.numberOfLines = 0
            $0.font = .pretendardFont(weight: .regular, size: 14)
            $0.textColor = .gray800
        }
        dotView.do {
            $0.backgroundColor = .gray900
            $0.layer.cornerRadius = 2
        }
    }
}
