//
//  main.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/01.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import UIKit

let appDelegateClass: AnyClass = NSClassFromString("MashUp_iOSTests.TestAppDelegate") ?? AppDelegate.self

_ = UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    NSStringFromClass(UIApplication.self),
    NSStringFromClass(appDelegateClass)
)
