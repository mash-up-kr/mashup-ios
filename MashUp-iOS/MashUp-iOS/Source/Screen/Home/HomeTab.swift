//
//  HomeTab.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/25.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

enum HomeTab: Int, CaseIterable, Equatable {
    case seminarSchedule
    case myPage
}
extension HomeTab {
    var title: String {
        switch self {
        case .seminarSchedule: return "일정리스트"
        case .myPage: return "마이페이지"
        }
    }
    
    var activeIcon: UIImage? {
        switch self {
        case .seminarSchedule: return UIImage(systemName: "list.bullet")
        case .myPage: return UIImage(systemName: "person")
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .seminarSchedule: return UIImage(systemName: "list.bullet")
        case .myPage: return UIImage(systemName: "person")
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
