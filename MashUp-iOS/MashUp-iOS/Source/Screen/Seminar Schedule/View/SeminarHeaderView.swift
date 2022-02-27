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
    
    func configure(sectionMeta: SeminarSectionMeta) {
        self.titleLabel.text = sectionMeta.description
        self.sortButton.isHidden = sectionMeta == .upcoming
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
            $0.textColor = .black
            $0.font = .systemFont(ofSize: 24, weight: .bold)
        }
        self.sortButton.do {
            $0.setTitle("날짜 오름차순", for: .normal)
            $0.setImage(UIImage(systemName: "arrow.up.arrow.down"), for: .normal)
            $0.imageView?.tintColor = .black
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        }
    }
    
    private func setupLayout() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.sortButton)
        self.titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview().inset(12)
        }
        self.sortButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.top.bottom.equalToSuperview().inset(12)
        }
    }
    
}
