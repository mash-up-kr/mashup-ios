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
    
    var icons: (UIImage?, UIImage?) {
        (UIImage(systemName: "heart"), UIImage(systemName: "heart"))
        // TODO: - 이미지추가후 수정해야함
//        switch self {
//        case .design: return
//        case .android: return
//        case .iOS: return
//        case .web: return
//        case .node: return
//        case .spring: return
//        }
    }
}
