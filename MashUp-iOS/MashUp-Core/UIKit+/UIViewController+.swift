//
//  UIViewController+.swift
//  MashUp-Core
//
//  Created by Booung on 2022/07/15.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    public static var rootViewController: UIViewController? {
        return UIApplication.shared.delegate?.window??.rootViewController
    }
    
    public class func visibleViewController(_ viewController: UIViewController? = UIViewController.rootViewController) -> UIViewController? {
        
        if let tabController = viewController as? UITabBarController {
            return visibleViewController(tabController.selectedViewController)
        } else if let naviController = viewController as? UINavigationController {
            return visibleViewController(naviController.visibleViewController)
        } else if let presentedController = viewController?.presentedViewController {
            return visibleViewController(presentedController)
        }
        return viewController
    }
    
}
