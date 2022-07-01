//
//  MUImage.swift
//  MashUp-UIKit
//
//  Created by 남수김 on 2022/07/01.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

public enum MUImage {
  case calender
  case check
  case chevronDown
  case chevronLeft
  case chevronRight
  case chevronUp
  case clock
  case close
  case error
  case info
  case qr
  case seminar
  case setting
  case triangle
  case user
  case xmark
  case facebook
  case instagram
  case mashup
  case mashupDark
  case notice
  case tistory
  case youtube
  
  public var asset: UIImage? {
    switch self {
    case .calender: return UIImage(named: "ic_calender")
    case .check: return UIImage(named: "ic_check")
    case .chevronDown: return UIImage(named: "ic_chevron_down")
    case .chevronLeft: return UIImage(named: "ic_chevron_left")
    case .chevronRight: return UIImage(named: "ic_chevron_right")
    case .chevronUp: return UIImage(named: "ic_chevron_up")
    case .clock: return UIImage(named: "ic_clock")
    case .close: return UIImage(named: "ic_close")
    case .error: return UIImage(named: "ic_error")
    case .info: return UIImage(named: "ic_info")
    case .qr: return UIImage(named: "ic_qr")
    case .seminar: return UIImage(named: "ic_seminar")
    case .setting: return UIImage(named: "ic_setting")
    case .triangle: return UIImage(named: "ic_triangle")
    case .user: return UIImage(named: "ic_user")
    case .xmark: return UIImage(named: "ic_xmark")
    case .facebook: return UIImage(named: "img_facebook")
    case .instagram: return UIImage(named: "img_instagram")
    case .mashup: return UIImage(named: "img_mashup")
    case .mashupDark: return UIImage(named: "img_mashup_dark")
    case .notice: return UIImage(named: "img_notice")
    case .tistory: return UIImage(named: "img_tistory")
    case .youtube: return UIImage(named: "img_youtube")
    }
  }
}
