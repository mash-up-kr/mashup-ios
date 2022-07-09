//
//  AttendanceHistorySectionHeaderView.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/07/08.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import Then
import SnapKit
import MashUp_Core
import MashUp_UIKit

struct AttendanceHistorySectionHeaderModel: Hashable {
    let generationText: String
}

final class AttendanceHistorySectionHeaderView: UITableViewHeaderFooterView, Reusable {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupAttribute()
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: AttendanceHistorySectionHeaderModel) {
        self.generationBadgeView.text =  model.generationText
    }
    
    private let generationBadgeView = PaddingLabel()
    
}

extension AttendanceHistorySectionHeaderView {
    
    private func setupAttribute() {
        self.contentView.backgroundColor = .gray50
        self.generationBadgeView.do {
            $0.backgroundColor = .white
            $0.textColor = .gray500
            $0.font = .pretendardFont(weight: .bold, size: 14)
            $0.contentInsets = UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6)
            $0.layer.cornerRadius = 4
            $0.clipsToBounds = true
            $0.addShadow(x: 2, y: 20, color: .black.withAlphaComponent(0.1), radius: 4)
        }
    }
    
    private func setupLayout() {
        self.contentView.addSubview(self.generationBadgeView)
        self.generationBadgeView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().inset(20)
        }
    }
    
}
