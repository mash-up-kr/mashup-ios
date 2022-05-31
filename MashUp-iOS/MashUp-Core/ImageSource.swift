//
//  ImageSourcve.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/05/29.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

enum ImageSource {
    case urlPath(String)
    case url(URL)
    case data(Data)
    case asset(String)
    case image(UIImage)
}
