//
//  MUButtonAttribute.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/05/29.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import UIKit

struct MUButtonAttribute {
    let titleColor: UIColor
    let titleFont: UIFont
    let backgroundColor: UIColor
}
extension MUButtonAttribute {
    
    init(from style: MUButtonStyle) {
        switch style {
        case .primary:
            self.titleColor = .white
            self.backgroundColor = .primary
        case .sort3:
            self.titleColor = .primary
            self.backgroundColor = .white
        case .default:
            self.titleColor = .gray600
            self.backgroundColor = .white
        }
        self.titleFont = .pretendardFont(weight: .medium, size: 16)
    }
}
