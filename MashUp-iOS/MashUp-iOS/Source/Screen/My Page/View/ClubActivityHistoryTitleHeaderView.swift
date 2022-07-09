//
//  AttendanceHistoryTitleHeaderView.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/07/08.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_Core
import MashUp_UIKit

struct ClubActivityHistoryTitleHeaderModel: Hashable {
    let title: String
}

final class ClubActivityHistoryTitleHeaderView: UITableViewHeaderFooterView, Reusable {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupAttribute()
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: ClubActivityHistoryTitleHeaderModel) {
        self.titleLabel.text = model.title
    }
    
    private let titleLabel = UILabel()
    
}

extension ClubActivityHistoryTitleHeaderView {
    
    private func setupAttribute() {
        self.contentView.backgroundColor = .gray50
        self.titleLabel.do {
            $0.textColor = .gray700
            $0.font = .pretendardFont(weight: .bold, size: 14)
        }
    }
    
    private func setupLayout() {
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.height.equalTo(17)
        }
    }
    
}
