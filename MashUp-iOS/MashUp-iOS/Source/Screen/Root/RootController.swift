//
//  RootViewController.swift
//  MashUp-iOS
//
//  Created by Booung on 2022/02/25.
//  Copyright © 2022 Mash Up Corp. All rights reserved.
//

import ReactorKit
import UIKit

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
        .subscribe(onNext: { [weak self] step in
            switch step {
            case .splash:
                self?.presentSplashViewController()
                
            case .signIn:
                self?.switchToSignInViewController()
                
            case .home(let userSession):
                self?.switchToHomeTabBarController(with: userSession)
            }
        }).disposed(by: self.disposeBag)
    }
    
    #warning("DIContainer로 로직 이동해야합니다., 가구현체여서 실구현체로 대치되어야합니다")
    let userSessionRepository = FakeUserSessionRepository()
    
}
// MARK: - Navigation
extension RootController {
    
    private func presentSplashViewController() {
        guard let splashViewController = self.createSplashViewController() else { return }
        splashViewController.modalPresentationStyle = .fullScreen
        self.present(splashViewController, animated: false, completion: nil)
    }
    
    private func switchToSignInViewController() {
        let signInViewController = self.createSignInViewController()
        signInViewController.modalPresentationStyle = .fullScreen
        self.switchToViewController(signInViewController)
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
        
        #warning("둘 중 하나만 주석을 푸시면 케이스 테스트 가능합니다.")
        
        // ✅ 자동 로그인 케이스 테스트
        self.userSessionRepository.stubedUserSession = UserSession(accessToken: "fake.access.token")
        
        // ❌ 자동 로그인 아닌 케이스 테스트
        // self.userSessionRepository.stubedUserSession = nil
        
        let splashViewController = SplashViewController()
        splashViewController.reactor = SplashReactor(
            userSessionRepository: self.userSessionRepository,
            authenticationResponder: authenticationResponder
        )
        return splashViewController
    }
    
    private func createSignInViewController() -> UIViewController {
        let reactor = SignInReactor(userSessionRepository: self.userSessionRepository)
        let viewController = SignInViewController()
        viewController.reactor = reactor
        return viewController
    }
    
    private func createHomeTabController() -> UIViewController {
        let homeTabBarController = HomeTabBarController()
        homeTabBarController.reactor = HomeReactor()
        return homeTabBarController
    }
    
}
