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
    
    public func resized(side: CGFloat) -> UIImage {
        return self.resized(width: side, height: side)
    }
    
}

extension UIImage {
    public static var img_placeholder_sleeping: UIImage? { UIImage(named: "img_placeholder_sleeping") }
    
    public static var img_absent: UIImage? { UIImage(named: "img_absent") }
    public static var img_attendance: UIImage? { UIImage(named: "img_attendance") }
    public static var img_card_bg: UIImage? { UIImage(named: "img_card_bg") }
    public static var img_facebook: UIImage? { UIImage(named: "img_facebook") }
    public static var img_hackathonprepare: UIImage? { UIImage(named: "img_hackathonprepare") }
    public static var img_instagram: UIImage? { UIImage(named: "img_instagram") }
    public static var img_late: UIImage? { UIImage(named: "img_late") }
    public static var img_mashong_crying: UIImage? { UIImage(named: "img_mashong_crying") }
    public static var img_mashup: UIImage? { UIImage(named: "img_mashup") }
    public static var img_mashup_dark: UIImage? { UIImage(named: "img_mashup_dark") }
    public static var img_mashupcontentswrite: UIImage? { UIImage(named: "img_mashupcontentswrite") }
    public static var img_mashupleader: UIImage? { UIImage(named: "img_mashupleader") }
    public static var img_mashupsubleader: UIImage? { UIImage(named: "img_mashupsubleader") }
    public static var img_notice: UIImage? { UIImage(named: "img_notice") }
    public static var img_presentation: UIImage? { UIImage(named: "img_presentation") }
    public static var img_projectfail: UIImage? { UIImage(named: "img_projectfail") }
    public static var img_projectleader: UIImage? { UIImage(named: "img_projectleader") }
    public static var img_projectsubleader: UIImage? { UIImage(named: "img_projectsubleader") }
    public static var img_projectsuccess: UIImage? { UIImage(named: "img_projectsuccess") }
    public static var img_profile_android: UIImage? { UIImage(named: "img_profile_android") }
    public static var img_profile_design: UIImage? { UIImage(named: "img_profile_design") }
    public static var img_profile_iOS: UIImage? { UIImage(named: "img_profile_iOS") }
    public static var img_profile_node: UIImage? { UIImage(named: "img_profile_node") }
    public static var img_profile_spring: UIImage? { UIImage(named: "img_profile_spring") }
    public static var img_profile_web: UIImage? { UIImage(named: "img_profile_web") }
    public static var img_staff: UIImage? { UIImage(named: "img_staff") }
    public static var img_splash: UIImage? { UIImage(named: "img_splash") }
    public static var img_techblogwrite: UIImage? { UIImage(named: "img_techblogwrite") }
    public static var img_tistory: UIImage? { UIImage(named: "img_tistory") }
    public static var img_youtube: UIImage? { UIImage(named: "img_youtube") }
    
    public static var ic_check: UIImage? { UIImage(named: "ic_check") }
    public static var ic_chevron_down: UIImage? { UIImage(named: "ic_chevron_down") }
    public static var ic_chevron_left: UIImage? { UIImage(named: "ic_chevron_left") }
    public static var ic_chevron_right: UIImage? { UIImage(named: "ic_chevron_right") }
    public static var ic_chevron_up: UIImage? { UIImage(named: "ic_chevron_up") }
    public static var ic_clock: UIImage? { UIImage(named: "ic_clock") }
    public static var ic_close: UIImage? { UIImage(named: "ic_close") }
    public static var ic_error: UIImage? { UIImage(named: "ic_error") }
    public static var ic_info: UIImage? { UIImage(named: "ic_info") }
    public static var ic_qr: UIImage? { UIImage(named: "ic_qr") }
    public static var ic_seminar: UIImage? { UIImage(named: "ic_seminar") }
    public static var ic_setting: UIImage? { UIImage(named: "ic_setting") }
    public static var ic_triangle: UIImage? { UIImage(named: "ic_triangle") }
    public static var ic_user: UIImage? { UIImage(named: "ic_user") }
    public static var ic_xmark: UIImage? { UIImage(named: "ic_xmark") }
}
