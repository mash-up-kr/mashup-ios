//
//  ImageProvider.swift
//  MashUp-Core
//
//  Created by 남수김 on 2022/07/03.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

public protocol ImageProvider {
  func image(urlString: String) async throws -> UIImage?
  func image(data: Data) -> UIImage?
  func image(muImage: MUImage) -> UIImage?
}
