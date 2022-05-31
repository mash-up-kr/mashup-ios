//
//  PlatformTeamMenuModel.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/05/31.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation


enum PlatformTeamMenuViewModel: CaseIterable, MUMenu {
    
    case design
    case android
    case iOS
    case web
    case node
    case spring
    
    var description: String {
        switch self {
        case .design: return "Product Design"
        case .android: return "Android"
        case .iOS: return "iOS"
        case .web: return "Web"
        case .node: return "Node"
        case .spring: return "Spring"
        }
    }
    
}

extension PlatformTeamMenuViewModel {
    
    init(model: PlatformTeam) {
        switch model {
        case .design: self = .design
        case .android: self = .android
        case .iOS: self = .iOS
        case .web: self = .web
        case .node: self = .node
        case .spring: self = .spring
        }
    }
}
