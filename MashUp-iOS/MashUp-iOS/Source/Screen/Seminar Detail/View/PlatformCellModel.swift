//
//  PlatformCellModel.swift
//  MashUp-iOS
//
//  Created by 남수김 on 2022/03/17.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

struct PlatformCellModel {
    let title: String
    let image: UIImage?
    let platform: PlatformTeam?
    
    init(platform: PlatformTeam?) {
        self.platform = platform
        switch platform {
        case .design:
            title = "Design"
            image = UIImage(systemName: "moon.fill")
        case .android:
            title = "Android"
            image = UIImage(systemName: "moon.fill")
        case .iOS:
            title = "iOS"
            image = UIImage(systemName: "moon.fill")
        case .web:
            title = "Web"
            image = UIImage(systemName: "moon.fill")
        case .node:
            title = "Node"
            image = UIImage(systemName: "moon.fill")
        case .spring:
            title = "Spring"
            image = UIImage(systemName: "moon.fill")
        default:
            title = "전체"
            image = nil
        }
    }
}

extension PlatformCellModel {
    static let models: [PlatformCellModel] = [
        PlatformCellModel(platform: nil),
        PlatformCellModel(platform: .android),
        PlatformCellModel(platform: .design),
        PlatformCellModel(platform: .iOS),
        PlatformCellModel(platform: .node),
        PlatformCellModel(platform: .spring),
        PlatformCellModel(platform: .node)
    ]
}
