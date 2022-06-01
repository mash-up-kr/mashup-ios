//
//  MUCanvasMenu.swift
//  MashUp-UICanvas
//
//  Created by Booung on 2022/06/01.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

enum MUCanvasMenu: String, CaseIterable {
  // 테스트 하고 싶은 MashUp-UIKit 요소 테스트
  case button = "버튼"
}
extension MUCanvasMenu: CustomStringConvertible {
  var description: String { self.rawValue }
}
