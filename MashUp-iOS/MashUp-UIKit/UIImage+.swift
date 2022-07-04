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
  public func resized(width: CGFloat, height: CGFloat) -> UIImage {
    let size = CGSize(width: width, height: height)
    let render = UIGraphicsImageRenderer(size: size)
    let renderImage = render.image { context in
      self.draw(in: CGRect(origin: .zero, size: size))
    }
    return renderImage
  }
}

extension UIImage {
  static var calender: UIImage? { UIImage(named: "ic_calender") }
  static var check: UIImage? { UIImage(named: "ic_check") }
  static var chevronDown: UIImage? { UIImage(named: "ic_chevron_down") }
  static var chevronLeft: UIImage? { UIImage(named: "ic_chevron_left") }
  static var chevronRight: UIImage? { UIImage(named: "ic_chevron_right") }
  static var chevronUp: UIImage? { UIImage(named: "ic_chevron_up") }
  static var clock: UIImage? { UIImage(named: "ic_clock") }
  static var close: UIImage? { UIImage(named: "ic_close") }
  static var error: UIImage? { UIImage(named: "ic_error") }
  static var info: UIImage? { UIImage(named: "ic_info") }
  static var qr: UIImage? { UIImage(named: "ic_qr") }
  static var seminar: UIImage? { UIImage(named: "ic_seminar") }
  static var setting: UIImage? { UIImage(named: "ic_setting") }
  static var triangle: UIImage? { UIImage(named: "ic_triangle") }
  static var user: UIImage? { UIImage(named: "ic_user") }
  static var xmark: UIImage? { UIImage(named: "ic_xmark") }
  static var facebook: UIImage? { UIImage(named: "img_facebook") }
  static var instagram: UIImage? { UIImage(named: "img_instagram") }
  static var mashup: UIImage? { UIImage(named: "img_mashup") }
  static var mashupDark: UIImage? { UIImage(named: "img_mashup_dark") }
  static var notice: UIImage? { UIImage(named: "img_notice") }
  static var tistory: UIImage? { UIImage(named: "img_tistory") }
  static var youtube: UIImage? { UIImage(named: "img_youtube") }
}
