//
//  HomeTab.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/25.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit
import MashUp_UIKit

enum HomeTab: Int, CaseIterable, Equatable {
    case seminarSchedule
    case myPage
}
extension HomeTab {
    var title: String {
        switch self {
        case .seminarSchedule: return "세미나"
        case .myPage: return "마이페이지"
        }
    }
    
    var activeIcon: UIImage? {
        switch self {
        case .seminarSchedule: return UIImage.ic_seminar
        case .myPage: return UIImage.ic_user
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .seminarSchedule: return UIImage.ic_seminar
        case .myPage: return UIImage.ic_user
        }
    }
}
extension HomeTab {
    func asTabBarItem() -> UITabBarItem {
        return UITabBarItem(
            title: self.title,
            image: self.icon,
            selectedImage: self.activeIcon
        )
    }
}
