//
//  MUTextFieldStyle.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/05/29.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

struct MUTextFieldStyle: Equatable {
    let borderColor: UIColor
    let textColor: UIColor
    let textFont: UIFont
    let placeholderColor: UIColor
    let placeholderFont: UIFont
    let assistiveTextColor: UIColor
    let assistiveFont: UIFont
    let trailingIconImage: UIImage?
}

extension MUTextFieldStyle {
    
    init(status: MUTextField.Status) {
        switch status {
        case .inactive:
            self.borderColor = .gray300
            self.textColor = .gray800
            self.textFont = .pretendardFont(weight: .medium, size: 20)
            self.placeholderColor = .gray400
            self.placeholderFont = .pretendardFont(weight: .medium, size: 20)
            self.assistiveTextColor = .gray800
            self.assistiveFont = .pretendardFont(weight: .regular, size: 12)
            self.trailingIconImage = nil
        case .active:
            self.borderColor = .gray300
            self.textColor = .gray800
            self.textFont = .pretendardFont(weight: .medium, size: 20)
            self.placeholderColor = .gray600
            self.placeholderFont = .pretendardFont(weight: .medium, size: 13)
            self.assistiveTextColor = .gray800
            self.assistiveFont = .pretendardFont(weight: .regular, size: 12)
            self.trailingIconImage = nil
        case .focus:
            self.borderColor = .primary
            self.textColor = .gray800
            self.textFont = .pretendardFont(weight: .medium, size: 20)
            self.placeholderColor = .gray600
            self.placeholderFont = .pretendardFont(weight: .medium, size: 13)
            self.assistiveTextColor = .gray800
            self.assistiveFont = .pretendardFont(weight: .regular, size: 12)
            self.trailingIconImage = nil
        case .vaild:
            self.borderColor = .gray300
            self.textColor = .gray800
            self.textFont = .pretendardFont(weight: .medium, size: 20)
            self.placeholderColor = .gray600
            self.placeholderFont = .pretendardFont(weight: .medium, size: 13)
            self.assistiveTextColor = .gray800
            self.assistiveFont = .pretendardFont(weight: .regular, size: 12)
            self.trailingIconImage = UIImage(systemName: "checkmark")
        case .invaild:
            self.borderColor = .red700
            self.textColor = .gray800
            self.textFont = .pretendardFont(weight: .medium, size: 20)
            self.placeholderColor = .red700
            self.placeholderFont = .pretendardFont(weight: .medium, size: 13)
            self.assistiveTextColor = .red700
            self.assistiveFont = .pretendardFont(weight: .regular, size: 12)
            self.trailingIconImage = UIImage(systemName: "exclamationmark.circle")
        case .disable:
            self.borderColor = .gray300.withAlphaComponent(0.3)
            self.textColor = .gray800
            self.textFont = .pretendardFont(weight: .medium, size: 20)
            self.placeholderColor = .gray600.withAlphaComponent(0.3)
            self.placeholderFont = .pretendardFont(weight: .medium, size: 13)
            self.assistiveTextColor = .gray800
            self.assistiveFont = .pretendardFont(weight: .regular, size: 12)
            self.trailingIconImage = nil
        case .custom(let style):
            self = style
        }
    }
}
