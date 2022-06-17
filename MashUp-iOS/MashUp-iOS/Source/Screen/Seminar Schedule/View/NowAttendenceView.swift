//
//  NowAttendenceView.swift
//  MashUp-iOS
//
//  Created by 이문정 on 2022/06/18.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

class NowAttendenceView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        self.setupUI()
    }
    
    func configure(with model: SeminarCardCellModel) {
    }
    private let nowAttendanceLabel = UILabel()
    private let lineView = UIView()
    
}
extension NowAttendenceView {
    private func setupUI() {
        self.setupAttribute()
        self.setupLayout()
    }
    
    private func setupAttribute() {
    }
    
    private func setupLayout() {
    }
}
    
