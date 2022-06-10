//
//  MUActionSheetTableViewCell.swift
//  MashUp-UIKit
//
//  Created by Booung on 2022/06/11.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import UIKit
import MashUp_Core

class MUActionSheetTableViewCell: BaseTableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupAttribute()
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: MUActionSheetItem) {
        self.titleLabel.text = item.title
        
        switch item.style {
        case .`default`:
            self.checkImageView.isHidden = true
            self.titleLabel.textColor = .gray800
        case .selected:
            self.checkImageView.isHidden = false
            self.titleLabel.textColor = .primary
        }
    }
    
    private let titleLabel = UILabel()
    private let checkImageView = UIImageView()
    
}

extension MUActionSheetTableViewCell {
    
    private func setupAttribute() {
        self.titleLabel.font = .pretendardFont(weight: .medium, size: 16)
        self.checkImageView.image = UIImage(named: "ic20_checkmark")
    }
    
    private func setupLayout() {
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
        }
        self.contentView.addSubview(self.checkImageView)
        self.checkImageView.snp.makeConstraints {
            $0.width.height.equalTo(20)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
}
