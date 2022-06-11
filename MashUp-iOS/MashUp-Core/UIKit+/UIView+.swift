//
//  UIView+.swift
//  MashUp-Core
//
//  Created by 남수김 on 2022/06/10.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

extension UIView {
  /**
   - parameters:
    - x: 그림자 x위치
    - y: 그림자 y위치
    - color: 그림자 색
    - radius: 그림자 번짐정도
    - opacity: 그림자 투명도
   */
  public func addShadow(x: CGFloat, y: CGFloat, color: UIColor, radius: CGFloat, opacity: Float = 1.0) {
    self.layer.shadowOffset = .init(width: x, height: y)
    self.layer.shadowColor = color.cgColor
    self.layer.shadowRadius = radius
    self.layer.shadowOpacity = opacity
  }
}
