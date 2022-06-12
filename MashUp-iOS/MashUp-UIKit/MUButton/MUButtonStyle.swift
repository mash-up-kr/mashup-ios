//
//  MUButtonStyle.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/05/29.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

public struct MUButtonStyle {
    let titleColor: UIColor
    let titleFont: UIFont
    let backgroundColor: UIColor
}
extension MUButtonStyle {
    
    public static let primary = MUButtonStyle(titleColor: .white,
                                              titleFont: .pretendardFont(weight: .medium, size: 16),
                                              backgroundColor: .primary500)
    
    public static let sort3 = MUButtonStyle(titleColor: .primary500,
                                            titleFont: .pretendardFont(weight: .medium, size: 16),
                                            backgroundColor: .white)
    
    public static let `default` = MUButtonStyle(titleColor: .gray600,
                                                titleFont: .pretendardFont(weight: .medium, size: 16),
                                                backgroundColor: .white)
}

