//
//  SeminarHeaderView.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/27.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import SnapKit
import Then
import UIKit
import MashUp_Core

protocol SeminarHeaderViewDelegate: AnyObject {
    func seminarHeaderView(_ headerView: SeminarHeaderView, didTapSort sort: Sort)
}

enum Sort {
    case asc
    case desc
}

final class SeminarHeaderView: UICollectionReusableView, Reusable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    func configure(sectionType: SeminarSectionType) {
        self.titleLabel.text = sectionType.header
    }
    
    private let sortButton = UIButton()
    private let titleLabel = UILabel()

}
// MARK: - Setup
extension SeminarHeaderView {
    
    private func setupUI() {
        self.setupAttribute()
        self.setupLayout()
    }
    
    private func setupAttribute() {
        self.titleLabel.do {
            $0.numberOfLines = 2
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 24, weight: .bold)
        }
        self.sortButton.do {
            $0.setTitle("일정 새로고침", for: .normal)
            $0.backgroundColor = .white
            $0.layer.cornerRadius = 6
            $0.layer.borderWidth = 2
            $0.layer.borderColor = UIColor.gray200.cgColor
            $0.setTitleColor(.gray700, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
            //            $0.setImage(UIImage(systemName: "arrow.up.arrow.down"), for: .normal)
            //            $0.imageView?.tintColor = .black
        }
    }
    
    private func setupLayout() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.sortButton)
        self.titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(-4)
            $0.centerY.equalToSuperview()
        }
        self.sortButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(19)
            $0.leading.equalTo(self.titleLabel.snp.trailing).inset(26)
            $0.top.equalTo(self.titleLabel.snp.top)
        }
    }
    
}
