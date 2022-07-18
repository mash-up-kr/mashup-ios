//
//  RootViewController.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/25.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import ReactorKit
import UIKit
import MashUp_Core
import MashUp_Auth
import MashUp_User
import MashUp_UIKit

final class RootController: BaseViewController, ReactorKit.View {
    typealias Reactor = RootReactor
    
    var disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
    }
    
    func bind(reactor: RootReactor) {
        self.dispatch(to: reactor)
        self.consume(reactor)
    }
    
    private func dispatch(to reactor: Reactor) {
        self.rx.viewDidLayoutSubviews.take(1).map { .didSetup }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
    }
    
    private func consume(_ reactor: Reactor) {
        reactor.pulse(\.$step).compactMap { $0 }
            .withUnretained(self)
            .onMain()
            .subscribe(onNext: { $0.move(to: $1) })
            .disposed(by: self.disposeBag)
        
        reactor.pulse(\.$toastMessage).compactMap { $0 }
            .onMain()
            .subscribe(onNext: { [weak self] in self?.showToast(message: $0) })
            .disposed(by: self.disposeBag)
    }
    
    private func showToast(message: String) {
        #warning("Toast로 바뀔 예정 - booung")
        let alert = MUActionAlertViewController(title: message)
        let confirm = MUAlertAction(title: "확인", style: .primary)
        alert.addAction(confirm)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            guard let visableViewController = UIViewController.visibleViewController() else { return }
            visableViewController.present(alert, animated: true)
        })
    }
    
    #warning("DIContainer로 로직 이동해야합니다., 가구현체여서 실구현체로 대치되어야합니다")
    private let userAuthServiceProvider = UserAuthServiceProvider()
    
}
// MARK: - Navigation
extension RootController {
    
    private func move(to step: RootStep) {
        switch step {
        case .splash:
            self.presentSplashViewController()
            
        case .signIn:
            self.switchToSignInViewController()
            
        case .home(let userSession):
            self.switchToHomeTabBarController(with: userSession)
        }
    }
    
    private func presentSplashViewController() {
        guard let splashViewController = self.createSplashViewController() else { return }
        splashViewController.modalPresentationStyle = .fullScreen
        self.present(splashViewController, animated: false, completion: nil)
    }
    
    private func switchToSignInViewController() {
        guard let signInViewController = self.createSignInViewController() else { return }
        let naviController = UINavigationController(rootViewController: signInViewController)
        naviController.modalPresentationStyle = .fullScreen
        naviController.navigationBar.isHidden = true
        self.switchToViewController(naviController)
    }
    
    private func switchToHomeTabBarController(with userSession: UserSession) {
        let homeTabBarController = self.createHomeTabController()
        homeTabBarController.modalPresentationStyle = .fullScreen
        self.switchToViewController(homeTabBarController)
    }
    
    private func switchToViewController(_ viewController: UIViewController) {
        if let presentedViewController = self.presentedViewController {
            presentedViewController.dismiss(animated: false, completion: {
                self.present(viewController, animated: false, completion: nil)
            })
        } else {
            self.present(viewController, animated: false, completion: nil)
        }
    }
    
}

// MARK: - Factory
extension RootController {
    
    private func createSplashViewController() -> UIViewController? {
        guard let authenticationResponder = self.reactor else { return nil }
        
        
//        let userAuthService = self.userAuthServiceProvider.provide()
        let userAuthService = FakeUserAuthService()
        #warning("둘 중 하나만 주석을 푸시면 케이스 테스트 가능합니다.")
        
        // ✅ 자동 로그인 케이스 테스트
        userAuthService.stubedUserSession = UserSession(
            id: "fake.user.id",
            accessToken: "fake.access.token",
            name: "fake.user.name",
            platformTeam: .iOS,
            generations: [12]
        )
        
        
        // ❌ 자동 로그인 아닌 케이스 테스트
//        userAuthService.stubedUserSession = nil
        
        let splashViewController = SplashViewController()
        splashViewController.reactor = SplashReactor(
            userAuthService: userAuthService,
            authenticationResponder: authenticationResponder
        )
        return splashViewController
    }
    
    private func createSignInViewController() -> UIViewController? {
        guard let authenticationResponder = self.reactor else { return nil }
        let userAuthService = self.userAuthServiceProvider.provide()
        
        let reactor = SignInReactor(
            userAuthService: userAuthService,
            verificationService: VerificationServiceImpl(),
            authenticationResponder: authenticationResponder
        )
        let viewController = SignInViewController()
        #warning("DIContainer 적용 후 제거되어야합니다 - booung")
        viewController.authenticationResponder = authenticationResponder
        viewController.reactor = reactor
        return viewController
    }
    
    private func createHomeTabController() -> UIViewController {
        let homeTabBarController = HomeTabBarController()
        let userAuthService = FakeUserAuthService()
        userAuthService.stubedSignOutResult = true
        #warning("DIContainer 적용 후 제거되어야합니다 - booung")
        homeTabBarController.userAuthService = userAuthService
        homeTabBarController.authenticationResponder = self.reactor
        homeTabBarController.reactor = HomeReactor()
        return homeTabBarController
    }
    
}
