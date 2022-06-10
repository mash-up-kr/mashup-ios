//
//  UIConstants.swift
//  MashUp-Core
//
//  Created by Booung on 2022/06/11.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

public var screenWidth: CGFloat {
    UIScreen.main.bounds.width
}

public var screenHeight: CGFloat {
    UIScreen.main.bounds.height
}

public var statusBarHeight: CGFloat {
    UIWindow.statusBarHeight
}

public var safeAreaTopPadding: CGFloat {
    UIWindow.current?.safeAreaInsets.top ?? 0
}

public var safeAreaLeftPadding: CGFloat {
    UIWindow.current?.safeAreaInsets.left ?? 0
}

public var safeAreaRightPadding: CGFloat {
    UIWindow.current?.safeAreaInsets.right ?? 0
}

public var safeAreaBottomPadding: CGFloat {
    UIWindow.current?.safeAreaInsets.bottom ?? 0
}

public var safeAreaWidth: CGFloat? {
    let safeAreaFrame = UIWindow.current?.safeAreaLayoutGuide.layoutFrame
    return safeAreaFrame?.width
}

public var safeAreaHeight: CGFloat? {
    let safeAreaFrame = UIWindow.current?.safeAreaLayoutGuide.layoutFrame
    return safeAreaFrame?.height
}
