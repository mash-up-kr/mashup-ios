//
//  Team.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/24.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

enum PlatformTeam: Equatable {
    case design
    case android
    case iOS
    case web
    case node
    case spring
    
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
