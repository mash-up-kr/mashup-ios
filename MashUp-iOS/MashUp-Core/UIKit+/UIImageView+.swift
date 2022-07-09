//
//  UIImageView+.swift
//  MashUp-Core
//
//  Created by 남수김 on 2022/07/04.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
  public func image(from source: ImageSource) {
    switch source {
    case .urlString(let urlString):
      guard let url = URL(string: urlString) else { return }
      self.kf.setImage(with: url, options: [.cacheMemoryOnly, .backgroundDecode, .transition(.fade(0.3))])
    case .data(let data):
      self.image = UIImage(data: data)
    case .asset(let image):
      self.image = image
    }
  }
}
