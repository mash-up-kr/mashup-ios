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
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(12)
        }
        
        leadingImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setupAttribute() {
        titleLabel.textColor = .gray800
        titleLabel.font = .pretendardFont(weight: .medium, size: 14)
        containerView.layer.cornerRadius = 8
        containerView.backgroundColor = .white
    }
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setImage(_ image: UIImage?) {
        leadingImageView.image = image
    }
}
