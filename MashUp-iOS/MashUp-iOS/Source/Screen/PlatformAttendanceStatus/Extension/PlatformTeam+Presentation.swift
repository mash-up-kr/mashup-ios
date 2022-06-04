//
//  PlatformTeam+Presentation.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/06/04.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_PlatformTeam

extension PlatformTeam {
    var title: String {
        switch self {
        case .design: return "Product Design"
        case .android: return "Android"
        case .iOS: return "iOS"
        case .web: return "Web"
        case .node: return "Node"
        case .spring: return "Spring"
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .design: return UIImage(systemName: "heart")
        case .android: return UIImage(systemName: "heart")
        case .iOS: return UIImage(systemName: "heart")
        case .web: return UIImage(systemName: "heart")
        case .node: return UIImage(systemName: "heart")
        case .spring: return UIImage(systemName: "heart")
        }
    }
}
