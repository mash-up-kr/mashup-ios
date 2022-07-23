//
//  PlatformAttendanceHeaderView.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/06/06.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_Core

final class PlatformAttendanceHeaderView: UICollectionReusableView, Reusable {
    private let containerView: UIView = UIView()
    private let leadingImageView: UIImageView = UIImageView()
    private let titleLabel: UILabel = UILabel()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        setupLayout()
        setupAttribute()
    }
    
    private func setupLayout() {
        addSubview(containerView)
        containerView.addSubview(leadingImageView)
        containerView.addSubview(titleLabel)
        
        containerView.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(12)
        }
        
        leadingImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(leadingImageView.snp.trailing).offset(6)
            $0.centerY.equalTo(leadingImageView)
        }
    }
    
    private func setupAttribute() {
        titleLabel.do {
            $0.textColor = .gray800
            $0.font = .pretendardFont(weight: .medium, size: 14)
        }
        containerView.do {
            $0.layer.cornerRadius = 8
            $0.backgroundColor = .white
            $0.addShadow(x: 0, y: 2, color: .black, radius: 20, opacity: 0.1)
        }
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setImage(_ image: UIImage?) {
        leadingImageView.image = image
    }
}
