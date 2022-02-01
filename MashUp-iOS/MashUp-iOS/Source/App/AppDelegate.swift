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
        window.rootViewController = self.createQRScanViewController()
        window.makeKeyAndVisible()
        return true
    }

    private func createQRScanViewController() -> UIViewController {
        let attendanceService = self.createAttendanceService()
        let reactor = FakeQRScanReactor(attendanceService: attendanceService)
        let viewController = FakeQRScanViewController()
        viewController.reactor = reactor
        return viewController
    }
    
    private func createAttendanceService() -> AttendanceService {
        #warning("실제 객체로 변경해야합니다.")
        let attendanceService = FakeAttendanceService()
        attendanceService.stubedCorrectCode = "Mash up iOS"
        return attendanceService
    }
}

