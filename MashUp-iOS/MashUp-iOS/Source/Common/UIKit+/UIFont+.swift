//
//  UIFont+.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/05/27.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

enum PretendardFontWeight {
    case regular, medium, semiBold, bold
}

extension UIFont {
    static func pretendardFont(weight: PretendardFontWeight, size: CGFloat) -> UIFont {
        switch weight {
        case .regular: return UIFont(name: "Pretendard-Regular", size: size)!
        case .medium: return UIFont(name: "Pretendard-Medium", size: size)!
        case .semiBold: return UIFont(name: "Pretendard-SemiBold", size: size)!
        case .bold: return UIFont(name: "Pretendard-Bold", size: size)!
        }
    }
}
