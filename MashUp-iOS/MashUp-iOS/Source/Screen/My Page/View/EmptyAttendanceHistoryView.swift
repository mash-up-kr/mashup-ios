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

final class EmptyAttendanceHistoryView: UITableViewHeaderFooterView, Reusable {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupAttribute()
        self.setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let emptyImageView = UIImageView()
    
}

extension EmptyAttendanceHistoryView {
    
    private func setupAttribute() {
        self.contentView.backgroundColor = .gray50
        self.emptyImageView.backgroundColor = .red
    }
    
    private func setupLayout() {
        self.contentView.addSubview(self.emptyImageView)
        self.emptyImageView.snp.makeConstraints {
            $0.width.equalTo(182)
            $0.height.equalTo(127)
            $0.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(42)
        }
    }
    
}
