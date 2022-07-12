//
//  SeminarDetailFooterView.swift
//  MashUp-iOS
//
//  Created by 이문정 on 2022/07/08.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import SnapKit
import Then
import UIKit
import MashUp_Core

final class SeminarDetailFooterView: UICollectionView.ReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    private let seperatorView = UIView()
}

extension SeminarDetailFooterView {
    private func setupUI() {
        self.setupAttribute()
        self.setupLayout()
    }
    
    private func setupAttribute() {
        self.seperatorView.do {
            $0.backgroundColor = .gray100
        }
    }
    
    private func setupLayout() {
        self.addSubview(self.seperatorView)
        self.seperatorView.snp.makeConstraints{
            $0.height.equalTo(1)
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
    }
}
