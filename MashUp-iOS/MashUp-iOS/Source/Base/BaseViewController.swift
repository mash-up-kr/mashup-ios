//
//  BaseViewController.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/24.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Then
import UIKit

class BaseViewController: UIViewController {
    
    enum TabBarTheme {
        case dark
        case light
    }
    
    override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        Logger.log("\(type(of:self)) init", .custom("🐥"), "", "", "")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        Logger.log("\(type(of:self)) init", .custom("🐥"), "", "", "")
    }
    
    deinit {
        Logger.log("\(type(of:self)) deinit", .custom("💀"), "", "", "")
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    func setupTabBarTheme(_ theme: TabBarTheme) {
        switch theme {
        case .dark:
            self.tabBarController?.tabBar.do {
                $0.barTintColor = .black
                $0.tintColor = .white
            }
        case .light:
            self.tabBarController?.tabBar.do {
                $0.barTintColor = .white
                $0.tintColor = .black
            }
        }
    }
}
