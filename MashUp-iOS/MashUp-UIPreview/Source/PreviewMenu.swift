//
//  MUCanvasMenu.swift
//  MashUp-UIPreview
//
//  Created by Booung on 2022/06/01.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation

enum PreviewMenu: String, CaseIterable {
  // Dynamic Library 에서 테스트하고 싶은 UI 추가
  case signUpCode = "가입코드 입력화면"
}
extension PreviewMenu: CustomStringConvertible {
  var description: String { self.rawValue }
}
