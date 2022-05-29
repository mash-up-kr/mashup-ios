//
//  MUButton.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/05/29.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//
import UIKit

class MUButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.round()
    }
    
    private func setupUI() {
        self.setBackgroundColor(.primary, for: .normal)
        self.setBackgroundColor(.primary.withAlphaComponent(0.3), for: .disabled)
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.white, for: .disabled)
    }
    
    private func round() {
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
    }
    
}
