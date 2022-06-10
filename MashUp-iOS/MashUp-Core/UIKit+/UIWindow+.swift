//
//  UIWindow+.swift
//  MashUp-Core
//
//  Created by Booung on 2022/06/11.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import Foundation
import UIKit

extension UIWindow {
    
    public static var current: UIWindow? {
        UIApplication.shared.windows.first(where: \.isKeyWindow)
    }
    
    public static var statusBarHeight: CGFloat {
        self.current?.statusBarHeight ?? .zero
    }
    
}
