//
//  MUAlertAction.swift
//  MashUp-UIKit
//
//  Created by 남수김 on 2022/06/29.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

public struct MUAlertAction {
  public typealias Style = MUButtonStyle
  
  let title: String?
  let handler: (() -> Void)?
  let style: Style
  
  public init(title: String?, style: MUAlertAction.Style, handler: (() -> Void)? = nil) {
    self.title = title
    self.handler = handler
    self.style = style
  }
}
