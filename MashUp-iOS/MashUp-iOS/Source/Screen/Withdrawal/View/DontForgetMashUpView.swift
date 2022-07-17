//
//  DontForgetMashUpView.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/07/08.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_Core

final class DontForgetMashUpView: BaseView {
    private let topImageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        addSubview(topImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        topImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(topImageView.snp.bottom).offset(10)
            $0.centerX.equalToSuperview()
        }
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func setupAttribute() {
        self.do {
            $0.backgroundColor = .gray100
            $0.layer.cornerRadius = 12
        }
        titleLabel.do {
            $0.text = "매시업을 잊지말아죠..."
            $0.font = .pretendardFont(weight: .bold, size: 16)
            $0.textColor = .gray800
        }
        descriptionLabel.do {
            $0.text = "탈퇴하시면 Admin에 저장된 모든 관련정보는 탈퇴일자 기준으로 3년간 보관된 후 삭제됩니다. 삭제된 정보는 복구할 수 없으니 신중하게 결정해주세요."
            $0.font = .pretendardFont(weight: .regular, size: 14)
            $0.textColor = .gray600
            $0.numberOfLines = 0
        }
    }
}
