//
//  MUButton.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/05/29.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//
import UIKit

class MUButton: UIButton {
    
    let style: MUButtonStyle
    
    init(frame: CGRect = .zero, style: MUButtonStyle = .primary) {
        self.style = style
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        self.style = .default
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.round()
    }
    
    private func setupUI() {
        self.setTitleColor(self.style.titleColor, for: .normal)
        self.setTitleColor(self.style.titleColor, for: .disabled)
        self.titleLabel?.font = self.style.titleFont
        self.setBackgroundColor(self.style.backgroundColor, for: .normal)
        self.setBackgroundColor(self.style.backgroundColor.withAlphaComponent(0.3), for: .disabled)
    }
    
    private func round() {
        self.layer.cornerRadius = 12
        self.clipsToBounds = true
    }
    
}
