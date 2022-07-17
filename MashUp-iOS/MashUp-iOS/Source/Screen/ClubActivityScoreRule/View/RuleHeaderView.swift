//
//  RuleHeaderView.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/06/29.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import MashUp_Core
import UIKit

final class RuleHeaderView: BaseView {
    private let imageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    
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
                    
    private func setupAttribute() {
        titleLabel.font = .pretendardFont(weight: .bold, size: 16)
        titleLabel.textColor = .gray900
    }
    
    private func setupLayout() {
        addSubview(imageView)
        addSubview(titleLabel)
        
        imageView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(imageView.snp.bottom).offset(22)
            $0.bottom.equalToSuperview()
            $0.height.equalTo(19)
        }
    }
    
    func setText(_ text: String) {
        titleLabel.text = text
    }
    
    func setImage(_ image: UIImage?) {
        imageView.image = image
    }
}
