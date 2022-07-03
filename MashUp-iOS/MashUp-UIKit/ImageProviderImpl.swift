//
//  ImageProviderImpl.swift
//  MashUp-UIKit
//
//  Created by 남수김 on 2022/07/03.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_Core
import Kingfisher

public final class ImageProviderImpl: ImageProvider {
  private init() {}
  public static let shared: ImageProviderImpl = ImageProviderImpl()
  
  public func image(urlString: String) async throws -> UIImage? {
    guard let url = URL(string: urlString) else { return nil }
    
    return try await withCheckedThrowingContinuation { continuation in
      KingfisherManager.shared.retrieveImage(with: url,
                                             options: [.cacheMemoryOnly, .backgroundDecode]) { result in
        switch result {
        case .success(let imageResult):
          continuation.resume(with: .success(imageResult.image))
        case .failure(let error):
          continuation.resume(throwing: error)
        }
      }
    }
  }
  
  public func image(data: Data) -> UIImage? {
    return UIImage(data: data)
  }
  
  public func image(muImage: MUImage) -> UIImage? {
    return muImage.asset
  }
}
