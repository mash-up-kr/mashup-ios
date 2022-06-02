//
//  BaseViewController.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/24.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Then
import UIKit

open class BaseViewController: UIViewController {
    
    public enum TabBarTheme {
        case dark
        case light
    }
    
    public override init(nibName: String?, bundle: Bundle?) {
        super.init(nibName: nibName, bundle: bundle)
        Logger.log("\(type(of:self)) init", .custom("🐥"), "", "", "")
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        Logger.log("\(type(of:self)) init", .custom("🐥"), "", "", "")
    }
    
    deinit {
        Logger.log("\(type(of:self)) deinit", .custom("💀"), "", "", "")
    }
    
    public override var shouldAutorotate: Bool {
        return false
    }
    
    public func setupTabBarTheme(_ theme: TabBarTheme) {
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
