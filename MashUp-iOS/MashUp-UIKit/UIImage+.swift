//
//  UIImage+.swift
//  MashUp-UIKit
//
//  Created by 남수김 on 2022/07/01.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

extension UIImage {
  /**
   - svg이미지를 넣을때
   - resizing옵션 -> preserve vector data옵션 클릭
   - scales옵션 -> single scale옵션으로 설정해야합니다.
   - **기본사이즈는 24**입니다.
   */
  public func resize(width: CGFloat, height: CGFloat) -> UIImage {
    let size = CGSize(width: width, height: height)
    let render = UIGraphicsImageRenderer(size: size)
    let renderImage = render.image { context in
      self.draw(in: CGRect(origin: .zero, size: size))
    }
    return renderImage
  }
}
