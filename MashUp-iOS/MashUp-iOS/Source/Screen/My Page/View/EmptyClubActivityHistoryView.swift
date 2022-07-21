//
//  EmptyAttendanceHistoryView.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/07/09.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Then
import SnapKit
import UIKit
import MashUp_Core
import MashUp_UIKit

final class EmptyClubActivityHistoryView: UITableViewHeaderFooterView, Reusable {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupAttribute()
        self.setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let emptyImageView = UIImageView()
    private let emptyLabel = UILabel()
    
}

extension EmptyClubActivityHistoryView {
    
    private func setupAttribute() {
        self.contentView.backgroundColor = .gray50
        self.emptyImageView.do {
            $0.image = .img_placeholder_sleeping
        }
        self.emptyLabel.do {
            $0.text = "아직 매시업 활동 내역이 없어요"
            $0.font = .pretendardFont(weight: .bold, size: 16)
            $0.textColor = .gray400
        }
    }
    
    private func setupLayout() {
        self.contentView.addSubview(self.emptyImageView)
        self.emptyImageView.snp.makeConstraints {
            $0.width.equalTo(120)
            $0.height.equalTo(80)
            $0.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(42)
        }
        self.contentView.addSubview(self.emptyLabel)
        self.emptyLabel.snp.makeConstraints {
            $0.top.equalTo(self.emptyImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
    }
    
}
