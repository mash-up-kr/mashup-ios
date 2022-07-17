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
    // a
    // b
    // c
    public static var calender: UIImage? { UIImage(named: "ic_calender") }
    public static var check: UIImage? { UIImage(named: "ic_check") }
    public static var chevronDown: UIImage? { UIImage(named: "ic_chevron_down") }
    public static var chevronLeft: UIImage? { UIImage(named: "ic_chevron_left") }
    public static var chevronRight: UIImage? { UIImage(named: "ic_chevron_right") }
    public static var chevronUp: UIImage? { UIImage(named: "ic_chevron_up") }
    public static var clock: UIImage? { UIImage(named: "ic_clock") }
    public static var close: UIImage? { UIImage(named: "ic_close") }
    // d
    // e
    public static var error: UIImage? { UIImage(named: "ic_error") }
    // f
    public static var facebook: UIImage? { UIImage(named: "img_facebook") }
    // g
    // h
    // i
    public static var info: UIImage? { UIImage(named: "ic_info") }
    public static var instagram: UIImage? { UIImage(named: "img_instagram") }
    // j
    // k
    // l
    // m
    public static var mashup: UIImage? { UIImage(named: "img_mashup") }
    public static var mashupDark: UIImage? { UIImage(named: "img_mashup_dark") }
    // n
    public static var notice: UIImage? { UIImage(named: "img_notice") }
    // o
    // p
    public static var placeholder: UIImage? { UIImage(named: "placeholder") }
    // q
    public static var qr: UIImage? { UIImage(named: "ic_qr") }
    // r
    // s
    public static var seminar: UIImage? { UIImage(named: "ic_seminar") }
    public static var setting: UIImage? { UIImage(named: "ic_setting") }
    // t
    public static var tistory: UIImage? { UIImage(named: "img_tistory") }
    public static var triangle: UIImage? { UIImage(named: "ic_triangle") }
    // u
    public static var user: UIImage? { UIImage(named: "ic_user") }
    // v
    // w
    // x
    public static var xmark: UIImage? { UIImage(named: "ic_xmark") }
    // y
    public static var youtube: UIImage? { UIImage(named: "img_youtube") }
    // z
   
}
