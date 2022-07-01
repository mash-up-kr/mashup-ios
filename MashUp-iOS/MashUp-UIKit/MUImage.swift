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
  case chevron_down
  case chevron_left
  case chevron_right
  case close
  case error
  case info
  case qr
  case seminar
  case setting
  case triangle
  case user
  case xmark
  
  public var asset: UIImage? {
    switch self {
    case .calender: return UIImage(named: "ic_calender")
    case .check: return UIImage(named: "ic_check")
    case .chevron_down: return UIImage(named: "ic_chevron_down")
    case .chevron_left: return UIImage(named: "ic_chevron_left")
    case .chevron_right: return UIImage(named: "ic_chevron_right")
    case .close: return UIImage(named: "ic_close")
    case .error: return UIImage(named: "ic_error")
    case .info: return UIImage(named: "ic_info")
    case .qr: return UIImage(named: "ic_qr")
    case .seminar: return UIImage(named: "ic_seminar")
    case .setting: return UIImage(named: "ic_setting")
    case .triangle: return UIImage(named: "ic_triangle")
    case .user: return UIImage(named: "ic_user")
    case .xmark: return UIImage(named: "ic_xmark")
    }
  }
}
