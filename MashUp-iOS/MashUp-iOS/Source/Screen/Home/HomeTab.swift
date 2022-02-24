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
    case setting
}
extension HomeTab {
    var title: String {
        switch self {
        case .seminarSchedule: return "일정리스트"
        case .myPage: return "마이페이지"
        case .setting: return "설정"
        }
    }
    
    var activeIcon: UIImage? {
        switch self {
        case .seminarSchedule: return UIImage(systemName: "list.bullet")
        case .myPage: return UIImage(systemName: "person")
        case .setting: return UIImage(systemName: "gear.circle")
        }
    }
    
    var icon: UIImage? {
        switch self {
        case .seminarSchedule: return UIImage(systemName: "list.bullet")
        case .myPage: return UIImage(systemName: "person")
        case .setting: return UIImage(systemName: "gear")
        }
    }
}
extension HomeTab {
    func asTabBarItem() -> UITabBarItem {
        return UITabBarItem(
            title: title,
            image: icon,
            selectedImage: activeIcon
        )
    }
}
