//
//  ImageSource.swift
//  MashUp-UIKit
//
//  Created by 남수김 on 2022/07/04.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

public enum ImageSource {
  case urlString(String)
  case data(Data)
  case asset(UIImage)
}
