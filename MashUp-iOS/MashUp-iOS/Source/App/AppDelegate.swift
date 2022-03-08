//
//  AppDelegate.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/01/10.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit


final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow()
        self.window = window
        window.rootViewController = self.createRootController()
        window.makeKeyAndVisible()
        
        return true
    }

    
    private func createRootController() -> UIViewController {
        let viewController = RootController()
        viewController.reactor = RootReactor()
        return viewController
    }
    
}

